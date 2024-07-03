<?php
namespace App\Trait;

use App\Models\Car;
use Illuminate\Support\Facades\Log;

trait Seats {
    public function makeSeatUnavailable(int $driverId, string $seats) : bool {
        $car = Car::where("driver_id",$driverId)->first();
        $carSeats = json_decode($car->seats, true);
        $selectedSeats = json_decode($seats, true);
        if($this->numberOfAvailableSeats($carSeats) == 0) return false;
        $updatedSeats = array_map(function (array $seat) use ($selectedSeats) {
            if(in_array($seat['seat'], $selectedSeats)){
                $seat['status'] = "unavailable";
            }
            return $seat;
        }, $carSeats );
        $car->seats = $updatedSeats;
        $car->save();
        return true;
    }

    private function numberOfAvailableSeats(array $carSeats) : int  {
        $availableSeats = array_filter($carSeats, function($seat){
            return $seat['status'] == 'available';
        });
        return count($availableSeats);
    }

    public function dropSeats($trip) : void
    {
        $seats = json_decode($trip->seats, true);
        $car = Car::where("user_id",$trip->driver_id)->first();
        $carSeats = json_decode($car->seats,true);
        $updatedSeats =  array_map(function(array $driverSeat) use ($seats) {
            if(in_array($driverSeat['seat'], $seats)){
                $driverSeat['status'] = "available";
            }
            return $driverSeat;
        }, $carSeats);
        $car->seats = json_encode($updatedSeats);
        $car->save();
    }
}
?>
