<?php
namespace App\Trait;

use App\Models\Driver;
use App\Models\Trip;
use Illuminate\Http\Request;

trait TaxiAlongTrip{


  public  function createTrip(Request $request, int $amount) : Trip {
        $driver = Driver::find($request->driver_id);
        return Trip::create([
            "payment_method" => $request->payment_method,
            "amount" => $amount,
            "rider_id" => $request->user()->id,
            "pointa" => $request->pointa,
            "pointb" => $request->pointb,
            "driver_id" => $driver->user_id,
            "ride_class" => $request->ride_class,
            "seats" => $request->seats,
            "car_id" => $request->car_id,
        ]);
    }
}
?>
