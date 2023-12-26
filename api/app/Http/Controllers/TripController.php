<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Trip;
use App\Models\User;
use App\Models\Driver;
use App\Models\BusStop;
use App\Http\Trait\Seats;
use App\Http\Trait\Distance;
use App\Models\RideSettings;
use Illuminate\Http\Request;
use App\Http\Trait\TaxiAlongTrip;
use Illuminate\Http\JsonResponse;
use App\Http\Trait\TaxiAlongWallet;
use App\Http\Trait\TaxiAlongTransaction;

class TripController extends Controller
{

    use Distance, TaxiAlongWallet, TaxiAlongTrip, Seats, TaxiAlongTransaction;

    public function availableRides(Request $request) : JsonResponse {

        $perPage = 10;
        $page = request()->input("page", 1);
        $pointa = $this->closestBusStop($request->pointAlatitude, $request->pointAlongitude);
        $pointb =  BusStop::find($request->pointb);
        $startlatitude = $pointa->latitude;
        $startlongitude = $pointa->longitude;


        $endlatitude = $pointb->latitude;
        $endlongitude = $pointb->longitude;
        $seat = $request->seat;
        $riderClass = json_decode($request->rider_class, true);

        $usersettings = RideSettings::where("user_id", auth()->user()->id)->first();
        $payment_method = $usersettings->payment_method ?? "cash";

        $drivers = Driver::where(["online" => 1])
                    ->select('latitude', 'longitude', 'id', 'seats')
                    ->selectRaw(
                        '(6371 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) AS distance',
                        [$startlatitude, $startlongitude, $startlatitude]
                    )
                    ->with(["settings"])
                    ->orderBy('distance')
                    ->skip(($page - 1) * $perPage)
                    ->take($perPage)
                    ->get();

        $drivers = $drivers->map(function ( $driver ) use($payment_method, $seat, $riderClass){
            $ride_class = json_decode($driver->settings->ride_class, true);

            $filteredClasses = array_filter($ride_class, function( $class ) use ($riderClass){
                return $riderClass === null || in_array($class['class'], $riderClass) || count($riderClass) == 0;
            });

            $driver->ride_class = $filteredClasses;

            return $driver;
        })->reject(function ($driver) use ($payment_method, $seat) {
            return ($payment_method !== null && $driver->settings->payment_method !== $payment_method ) ||
            ($seat !== null && $this->numberOfAvailableSeats(json_decode($driver->seats, true)) < $seat );
        });

        $avaiable_rides = $drivers->flatMap(function ( $driver ) use ($pointa, $startlatitude, $startlongitude, $pointb, $endlatitude, $endlongitude) {
            $rideClasses = $driver->ride_class;
            return array_map(function($class) use ($driver, $pointa, $startlatitude, $startlongitude, $pointb, $endlatitude, $endlongitude){
                $amount = $this->calculatePrice(
                    $class['class'],
                    [
                        "busstop" => $pointa->id,
                        "latitude" => $startlatitude,
                        "longitude" => $startlongitude,
                    ],
                    [
                        "busstop" => $pointb->id,
                        "latitude" => $endlatitude,
                        "longitude" => $endlongitude,
                    ]
                );

                if($amount !== false){
                    return [
                        "class"  => $class["class"],
                        "distance" => $driver->distance,
                        "payment_method" => $driver->settings->payment_method,
                        "amount" => $amount,
                        "driver" => User::find($driver->settings->user_id),
                        "seats" => json_decode($driver->seats),
                        "pointa" => $pointa->id,
                        "pointb" => $pointb->id,
                    ];
                }

            }, $rideClasses);
        });

        return response()->json([
            "status" => true,
            "message" => "Available Rides fetched",
            "data" => $avaiable_rides->filter()->values(),
        ]);
    }

    public function confirmRide(Request $request) : JsonResponse {
        try {
            if($this->hasSufficientFunds($request) || $this->isCashPayment($request)){
                $this->createAndBookTrip($request);
                return $this->riderRequestedTrip();
            }else{
                return response()->json([
                    "status" => false,
                    "message" => "Insufficient fund"
                ]);
            }
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error",
            ]);
        }

    }

    private function hasSufficientFunds(Request $request): bool {
        return $this->availableFund() >= $request->amount;
    }

    private function isCashPayment(Request $request): bool {
        return $request->payment_method == "cash";
    }

    private function createAndBookTrip(Request $request): ?Trip {
        if(!$this->makeSeatUnavailable($request->driver_id, $request->seats)){
            throw new Exception("Seats are not available for booking.");
        }
        if($request->payment_method == "wallet"){
            if(!$this->withdraw($request->amount, "fund")){
                throw new Exception("Insufficient fund");
            }
            $this->createTransaction($request->amount, "debit", 'Trip Payment');
        }
        return $this->createTrip($request);
    }

    public function recent(Request $request){

    }

    public function requests():  JsonResponse
    {
        if(auth()->user()->role == "driver") {
           return $this->driverRequestedTrips();
        }else{
            return $this->riderRequestedTrip();
        }
    }

    private function driverRequestedTrips() : JsonResponse
    {
        $trips = Trip::where(["driver_id" => auth()->user()->id, "status" => "requested"])->with(["riders", "location" ,'pointa', 'pointb'])->latest()->get();
        return response()->json(["status" => true, "message" => "Trip fetched", "data" => $trips]);
    }

    private function riderRequestedTrip() : JsonResponse
    {
        $trip = Trip::where(["rider_id" => auth()->user()->id, "status" => "requested"])->with(['driver', 'location', 'reviews','pointa', 'pointb'])->latest()->first();
        return response()->json(["status" => true, "message" => "Trip fetched", "data" => $trip]);
    }

    public function cancel(Request $request) : JsonResponse
    {
        Trip::whereId($request->tripId)->update([
            "status" => 'canceled',
            "reason" => $request->reason,
        ]);
        return response()->json(["status" => true, "message" => "Trip canceled"]);
    }
}
