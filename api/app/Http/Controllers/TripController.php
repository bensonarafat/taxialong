<?php

namespace App\Http\Controllers;

use App\Models\Driver;
use App\Http\Trait\Distance;
use Illuminate\Http\Request;

class TripController extends Controller
{

    use Distance;

    public function availableRides(Request $request){
        // NOTE: Filter by Class and Seat
        $latitude = $request->latitude;
        $longitude = $request->longitude;
        $payment_method = $request->payment_method;
        $seat = $request->seat;
        $drivers = Driver::where(["online" => 0])
                    ->select('latitude', 'longitude', 'id')
                    ->selectRaw(
                        '(6371 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) AS distance',
                        [$latitude, $longitude, $latitude]
                    )
                    ->with(["settings"])
                    ->orderBy('distance')
                    // ->limit($num)
                    ->get();
        foreach($drivers as $key => $row){
            $ride_class = json_decode($row->settings->ride_class);
            $row->ride_class = $ride_class;
            // if payment_method is not null
            if($payment_method != null) {
                if($row->settings->payment_method != $payment_method)  unset($drivers[$key]);
            }
            if($seat != null && $row->settings->seats != null ){
                // do something here
            }
        }
        return response()->json([
            "status" => true,
            "message" => "drivers fetched",
            "data" => $drivers,
        ]);
    }

    public function recent(Request $request){

    }

    public function ongoing(Request $request){

    }
}
