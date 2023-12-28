<?php
namespace App\Http\Trait;

use App\Models\RideSettings as settings;

trait RideSettings {

    public function createSettings(){
        settings::create([
            "user_id" => auth()->user()->id,
        ]);
    }
}

?>
