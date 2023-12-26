<?php
namespace App\Http\Trait;

use App\Models\Driver;

trait Seats {
    public function makeSeatUnavailable(int $driverId, string $seats) : bool {
        $driver = Driver::where("user_id",$driverId)->first();
        $driverSeats = json_decode($driver->seats, true);
        $selectedSeats = json_decode($seats, true);
        if($this->numberOfAvailableSeats($driverSeats) == 0) return false;
        $updatedSeats = array_map(function (array $seat) use ($selectedSeats) {
            if(in_array($seat['seat'], $selectedSeats)){
                $seat['status'] = "unavailable";
            }
            return $seat;
        }, $driverSeats );
        $driver->seats = $updatedSeats;
        $driver->save();
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
        $driver = Driver::where("user_id",$trip->driver_id)->first();
        $driverSeats = json_decode($driver->seats,true);
        $updatedSeats =  array_map(function(array $driverSeat) use ($seats) {
            if(in_array($driverSeat['seat'], $seats)){
                $driverSeat['status'] = "available";
            }
            return $driverSeat;
        }, $driverSeats);
        $driver->seats = json_encode($updatedSeats);
        $driver->save();
    }
}
?>
