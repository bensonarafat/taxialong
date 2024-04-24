<?php
namespace App\Trait;

use App\Models\RideSettings;

trait Rider {

    public function DriverTrip(){
        //check if exist
        $exist = RideSettings::where("user_id", auth()->user()->id)->exists();
        if(!$exist){
            //create ridesettings
            RideSettings::create([
                "user_id" => auth()->user()->id,
            ]);
        }

    }
}
?>
