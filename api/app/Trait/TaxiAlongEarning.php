<?php
namespace App\Trait;

use App\Models\Earning;

trait TaxiAlongEarning{

    public function createEarning($trip) : void
    {
        Earning::create([
            "user_id" => $trip->driver_id,
            "trip_id" => $trip->id,
            "payment_method" => $trip->payment_method,
            "amount" => $trip->amount,
            "description"=> "Earn $trip->amount"
        ]);
    }
}
