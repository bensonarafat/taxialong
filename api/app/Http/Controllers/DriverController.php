<?php

namespace App\Http\Controllers;

use Exception;
use Carbon\Carbon;
use App\Models\User;
use App\Models\Driver;
use App\Models\RideSettings;
use Illuminate\Http\Request;

class DriverController extends Controller
{
    public function driver(){
        $today = Carbon::today()->toDateString();
        $driver = Driver::where("user_id", auth()->user()->id)
                    ->withCount([
                        "earnings", "total_rides",
                        'today_ride' => function ($query) use ($today) {
                            $query->whereDate('created_at', $today);
                        }
                    ])
                    ->withSum('earnings', 'amount')->first();
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

    public function goOnline(){
        try {
            //check if the user account is verified
            $user = User::whereId(auth()->user()->id)->first();
            if($user->verified){
                $driver = Driver::where("user_id", auth()->user()->id)->first();
                // dd($driver->first());
                $driver->online = !$driver->online;
                $driver->save();
                return response()->json(
                    [
                        "status" => true,
                        "message" => "Status Updated",
                    ]
                );
            }else{
                return response()->json([
                    "status" => false,
                    "message" => "Sorry, your account yet to be verified, if you have not submitted your documents please do so."
                ]);
            }
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error",
                "error" => $e->getMessage()
            ]);
        }
    }
}
