<?php
namespace App\Http\Trait;

use App\Models\RideSettings as settings;

trait RideSettings {

    public function createSettings(){
        $exists = settings::where("user_id", auth()->user()->id)->exists();
        if(!$exists){
            settings::create([
                "user_id" => auth()->user()->id,
            ]);
        }

    }
}

?>
