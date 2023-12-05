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

            RideSettings::create([
                "user_id" => auth()->user()->id,
                "driver_id" => $driver->id,
            ]);
        }

    }
}
?>
