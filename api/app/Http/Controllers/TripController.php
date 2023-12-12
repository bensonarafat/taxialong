<?php

namespace App\Http\Controllers;

use App\Models\Driver;
use App\Http\Trait\Distance;
use Illuminate\Http\Request;

class TripController extends Controller
{

    use Distance;

    public function availableRides(Request $request){

        $perPage = 10;
        $page = request()->input("page", 1);

        //Current Location/Bus Stop
        $startlatitude = $request->latitude;
        $startlongitude = $request->longitude;
        $startbusstop = $request->startbustop;

        //Drop off Location/Bus Stop
        $endlatitude = $request->endlatitude;
        $endlongitude = $request->endlongitude;
        $endbusstop = $request->endbusstop;
        // NOTE: Filter by Class and Seat
        $payment_method = $request->payment_method;
        $seat = $request->seat;
        $riderClass = $request->rider_class;

        $drivers = Driver::where(["online" => 1])
                    ->select('latitude', 'longitude', 'id')
                    ->selectRaw(
                        '(6371 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) AS distance',
                        [$startlatitude, $startlongitude, $startlatitude]
                    )
                    ->with(["settings", "user"])
                    ->orderBy('distance')
                    ->skip(($page - 1) * $perPage)
                    ->take($perPage)
                    ->get();

        $drivers = $drivers->map(function ( $driver ) use($payment_method, $seat, $riderClass){
            $ride_class = json_decode($driver->settings->ride_class, true);

            $filteredClasses = array_filter($ride_class, function( $class ) use ($riderClass){
                return $riderClass === null || in_array($class['class'], $riderClass);
            });

            $driver->ride_class = $filteredClasses;

            return $driver;
        })->reject(function ($driver) use ($payment_method, $seat) {
            return ($payment_method !== null && $driver->settings->payment_method !== $payment_method ) ||
            ($seat !== null && ($driver->settings->seats == null || $driver->settings->seats === 0));
        });

        $avaiable_rides = $drivers->flatMap(function ( $driver ) use ($startbusstop, $startlatitude, $startlongitude, $endbusstop, $endlatitude, $endlongitude) {
            $rideClasses = $driver->ride_class;
            return array_map(function($class) use ($driver, $startbusstop, $startlatitude, $startlongitude, $endbusstop, $endlatitude, $endlongitude){
                $amount = $this->calculatePrice(
                    $class['class'],
                    [
                        "busstop" => $startbusstop,
                        "latitude" => $startlatitude,
                        "longitude" => $startlongitude,
                    ],
                    [
                        "busstop" => $endbusstop,
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
                        "driver" => $driver->user,
                        "seats" => "",
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


    public function recent(Request $request){

    }

    public function ongoing(Request $request){

    }
}
