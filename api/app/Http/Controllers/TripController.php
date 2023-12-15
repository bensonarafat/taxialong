<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Driver;
use App\Models\BusStop;
use App\Http\Trait\Distance;
use App\Models\RideSettings;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class TripController extends Controller
{

    use Distance;

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

        $drivers = Driver::where(["online" => 0])
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

    private function numberOfAvailableSeats(array $carSeats,) : int  {
        $availableSeats = array_filter($carSeats, function($seat){
            return $seat['available'] == true;
        });
        return count($availableSeats);
    }

    public function recent(Request $request){

    }

    public function ongoing(Request $request){

    }
}
