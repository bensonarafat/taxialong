<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Trip;
use App\Models\User;
use App\Trait\Seats;
use App\Models\Driver;
use App\Models\BusStop;
use App\Trait\Distance;
use App\Events\TripEvent;
use App\Models\Axis;
use App\Models\RideSettings;
use App\Trait\TaxiAlongTrip;
use Illuminate\Http\Request;
use App\Trait\TaxiAlongWallet;
use App\Trait\TaxiAlongEarning;
use Illuminate\Http\JsonResponse;
use App\Trait\TaxiAlongTransaction;
use Illuminate\Support\Facades\Log;

class TripController extends Controller
{
    const PER_PAGE = 10;
    const PAGE = 1;

    use Distance, TaxiAlongWallet, TaxiAlongTrip, Seats, TaxiAlongTransaction, TaxiAlongEarning;

    public function availableRides(Request $request) : JsonResponse {

        $perPage = self::PER_PAGE;
        $page = request()->input("page", self::PAGE);
        $pointa = $this->closestBusStop($request->pointAlatitude, $request->pointAlongitude);
        $pointb =  BusStop::find($request->pointb);
        $startlatitude = $pointa->latitude;
        $startlongitude = $pointa->longitude;

        $endlatitude = $pointb->latitude;
        $endlongitude = $pointb->longitude;
        $riderClass = $request->rider_class;

        $usersettings = RideSettings::where("user_id", auth()->user()->id)->first();
        $payment_method = $usersettings->payment_method ?? "cash";

        $drivers = Driver::where(["online" => 1])
                    ->select('latitude', 'longitude', 'id')
                    ->selectRaw(
                        '(6371 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) AS distance',
                        [$startlatitude, $startlongitude, $startlatitude]
                    )
                    ->with(["settings", "car", "user"])
                    ->orderBy('distance')
                    ->skip(($page - 1) * $perPage)
                    ->take($perPage)
                    ->get();


        $drivers = $drivers->map(function ($driver)  use ($pointa, $startlatitude, $startlongitude, $pointb, $endlatitude, $endlongitude, $riderClass, $payment_method) {
            // driver seats // if null
            if($driver->car->seats != null) {
                $seats = json_decode($driver->car->seats, true);
                $driver->seats = $seats;
            }else{
                $driver->seats = null;
            }
            $genclasses = [];
            if($driver->seats != null){
                $driverClasses = json_decode($driver->car->classes, true);
                if($riderClass != null){
                    $classes =  json_decode($riderClass, true);
                    // filter out classes not in the list
                    foreach ($driverClasses as $row) {
                        for ($i=0; $i < count($classes); $i++) {
                            if($classes[$i] == $row['class']){
                                $row['amount'] = $this->calculatePrice(
                                    $row['class'],
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
                                array_push($genclasses, $row);
                            }
                        }
                    }
                }else{
                    foreach ($driverClasses as $row) {
                        $row['amount'] = $this->calculatePrice(
                            $row['class'],
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
                        array_push($genclasses, $row);
                    }
                }
            }
            $driver->pointa = $pointa->id;
            $driver->pointb = $pointb->id;
            $driver->classes = $genclasses;
            // if payment is not == to driver remove the driver
            if($payment_method != $driver->settings->payment_method){
                return null;
            }else{
                return $driver;
            }
        });


        return response()->json([
            "status" => true,
            "message" => "Available Rides fetched",
            "data" => $drivers,
        ]);
    }


    public function confirmRide(Request $request) : JsonResponse {
        try {
            $rideclass = json_decode($request->ride_class, true);
            if($this->hasSufficientFunds($rideclass['amount']) || $this->isCashPayment($request->payment_method)){
                $this->createAndBookTrip($request, $rideclass);
                return response()->json(["status" => true, "message" => "booked"]);
            }else{
                return response()->json([
                    "status" => false,
                    "message" => "Insufficient fund"
                ]);
            }
        } catch (Exception $e) {
            Log::info($e->getMessage());
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error",
            ]);
        }

    }

    private function hasSufficientFunds($amount): bool {
        return $this->availableFund() >= $amount;
    }

    private function isCashPayment(String $payment_method): bool {
        return $payment_method == "cash";
    }

    private function createAndBookTrip(Request $request, Array $rideClass): ?Trip {
        if(!$this->makeSeatUnavailable($request->driver_id, $request->seats)){
            throw new Exception("Seats are not available for booking.");
        }
        if($request->payment_method == "wallet"){
            if(!$this->withdraw($rideClass['amount'], "fund")){
                throw new Exception("Insufficient fund");
            }
            $this->createTransaction($rideClass['amount'], "debit", 'Trip Payment');
        }
        return $this->createTrip($request, $rideClass['amount']);
    }

    public function recent(Request $request){
        $perPage = self::PER_PAGE;
        $page = request()->input("page", self::PAGE);
        $trips = Trip::where(["driver_id" => auth()->user()->id])
                    ->with(["rider", "location" ,'pointa', 'pointb'])
                    ->latest()
                    ->skip(($page - 1) * $perPage)
                    ->take($perPage)
                    ->get();
        return response()->json(["status" => true, "message" => "Trip fetched", "data" => $trips]);
    }

    public function requests():  JsonResponse
    {
        if(auth()->user()->role == "driver") {
           return $this->driverRequestedTrips();
        }else{
            return $this->riderRequestedTrip();
        }
    }

    private function riderRequestedTrip() : JsonResponse
    {
        $trip = Trip::where(["rider_id" => auth()->user()->id, "status" => "requested"])->with(['car', 'driver', 'tripDriver.settings.origin', 'tripDriver.settings.destination', 'location', 'reviews','pointa', 'pointb'])->latest()->first();

        $settings = RideSettings::where("user_id", $trip->driver_id)->first();
        $pointa = Axis::where("bus_stop_id", $settings->pointa)->first();
        $pointb = Axis::where("bus_stop_id", $settings->pointb)->first();
        $busStops = Axis::where(['point_a' => $pointa->point_a, 'point_b' => $pointa->point_b])
                    ->orWhere(['point_a' => $pointb->point_a, 'point_b' => $pointb->point_b])
                    ->with(['busStop'])->get();
        $busStopRelationships = [];
        foreach ($busStops as $busStop) {
            // access the related busStop object using the relationship property
            $busStopRelationship = $busStop->busStop;
            $busStopRelationships[] = $busStopRelationship;
        }
        $trip->bus_stops = $busStopRelationships;

        return response()->json(["status" => true, "message" => "Trip fetched", "data" => $trip]);
    }

    private function driverRequestedTrips() : JsonResponse
    {

        $perPage = self::PER_PAGE;
        $page = request()->input("page", self::PAGE);

        $trips = Trip::where(["driver_id" => auth()->user()->id, "status" => "requested"])
                        ->with(["rider", "location" ,'pointa', 'pointb'])
                        ->skip(($page - 1) * $perPage)
                        ->take($perPage)
                        ->latest()->get();
        return response()->json(["status" => true, "message" => "Trip fetched", "data" => $trips]);
    }


    public function cancel(Request $request) : JsonResponse
    {
        $trip = Trip::whereId($request->tripId)->first();
        TripEvent::dispatch($trip);
        $trip->status = 'canceled';
        $trip->reason = $request->reason;
        $trip->save();
        $this->dropSeats($trip);
        return response()->json(["status" => true, "message" => "Trip canceled"]);
    }

    public function updatePickup() : JsonResponse
    {
        $exists = Trip::where(["status" =>  "requested", "user_id" => auth()->user()->id])->exists();
        if($exists){
            $trip = Trip::where(["status" =>  "requested", "user_id" => auth()->user()->id])->first();
            $trip->status = "pickedup";
            $trip->save();
            TripEvent::dispatch($trip);
            return response()->json([
                "status" => true,
                "message" => "Trip Updated",
                "data" => $trip,
            ]);
        }else{
            return response()->json([
                "status" => false,
                "message" => "Nothing to update"
            ]);
        }


    }

    public function updateCompleted(Request $request) : JsonResponse
    {
        $exists = Trip::where(["status" => "pickedup", "user_id" => auth()->user()->id])->exists();
        if($exists){
            $trip = Trip::where(["status" => "pickedup", "user_id" => auth()->user()->id])->first();
            $trip->status = "completed";
            $trip->save();
            $this->createEarning($trip);
            $this->topUp($trip->amount, "fund", $trip->driver);
            if($trip->payment_method == "wallet"){
                $this->withdraw($trip->amount, "fund");
            }
            TripEvent::dispatch($trip);
            return response()->json([
                "status" => true,
                "message" => "Trip Updated"
            ]);
        }else{
            return response()->json([
                "status" => false,
                "message" => "Nothing to update"
            ]);
        }

    }

    public function history() : JsonResponse
    {
        $perPage = self::PER_PAGE;
        $page = request()->input("page", self::PAGE);
        $trips = Trip::
                    with(['pointa', 'pointb'])
                    ->skip(($page - 1) * $perPage)
                    ->take($perPage)
                    ->latest()->get();
        return response()->json(
            [
                "status" => true,
                "message" => "Trip fetched",
                "data" => $trips,
            ]
        );
    }

    public function tripPrice() : JsonResponse
    {

        return response()->json();
    }
}
