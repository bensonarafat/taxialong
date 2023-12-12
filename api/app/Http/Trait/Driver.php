<?php
namespace App\Http\Trait;

use App\Models\RideSettings;
use App\Models\Driver as driverModel;

trait Driver {
    public function DriverTrip(){
        //check if exist
        $exist = driverModel::where("user_id", auth()->user()->id)->exists();
        if(!$exist){
            //create driver
            $driver = driverModel::create([
                "user_id" => auth()->user()->id,
            ]);
        }
        // check if exist
        $exist2 = RideSettings::where(["user_id" => auth()->user()->id])->exists();
        if(!$exist2){
            RideSettings::create([
                "user_id" => auth()->user()->id,
                "driver_id" => $driver->id,
            ]);
        }else{
            //if exist but its null
            $exist3 = RideSettings::where(["user_id" => auth()->user()->id])->whereNull("driver_id")->exists();
            if($exist3){
                $driver = driverModel::where("user_id", auth()->user()->id)->first();
                //upate
                RideSettings::where("user_id", auth()->user()->id)->update([
                    "driver_id" => $driver->id
                ]);
            }
        }


    }
}
?>
