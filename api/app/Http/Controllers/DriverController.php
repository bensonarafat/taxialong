<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Driver;
use App\Models\RideSettings;
use Exception;
use Illuminate\Http\Request;

class DriverController extends Controller
{
    public function driver(){
        $today = Carbon::today()->toDateString();
        $driver = Driver::where("user_id", auth()->user()->id)
                    ->with(["user", "settings"])
                    ->withCount([
                        "earnings", "total_rides",
                        'today_ride' => function ($query) use ($today) {
                            $query->whereDate('created_at', $today);
                        }
                    ])
                    ->withSum('earnings', 'amount')->first();
        $driver->settings->ride_class = json_decode($driver->settings->ride_class);
        return response()->json([
            "status" => true,
            "message" => "Driver Fetched",
            "data" => $driver,
        ]);
    }

    //update driver position
    public function updatePosition(Request $request) {
        try {
            Driver::whereId($request->user()->id)->update([
                "latitude" => $request->latitude,
                "longitude" => $request->longitude,
            ]);
            return response()->json([
                "status" => true,
                "message" => "Position updated",
            ]);
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error"
            ]);
        }

    }

    //driver ride settings
    public function rideSettings(Request $request){
        //update
        try {
            RideSettings::where(["user_id" =>  $request->user()->id])->update([
                "pointa" => $request->pointa,
                "pointb" => $request->pointb,
                "payment_method" => $request->payment_method,
                "ride_class" => json_encode($request->ride_class),
            ]);
            return response()->json(["status" => true,  "message" => "Setting updated"]);
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error"
            ]);
        }

    }

    public function getSettings(){
        $settings = RideSettings::where("user_id", auth()->user()->id)->first();
        $settings->ride_class = json_decode($settings->ride_class);
        return response()->json(
            [
                "status" => true,
                "message" => "Settings fetched",
                "data" => $settings,
            ]
        );
    }
}
