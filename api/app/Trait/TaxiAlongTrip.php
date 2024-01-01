<?php
namespace App\Trait;

use App\Models\Trip;
use Illuminate\Http\Request;

trait TaxiAlongTrip{


  public  function createTrip(Request $request) : Trip {
        return Trip::create([
            "payment_method" => $request->payment_method,
            "amount" => $request->amount,
            "rider_id" => $request->user()->id,
            "pointa" => $request->pointa,
            "pointb" => $request->pointb,
            "driver_id" => $request->driver_id,
            "trip_class" => $request->trip_class,
            "seats" => $request->seats,
        ]);
    }
}
?>
