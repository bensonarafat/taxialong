<?php
namespace App\Http\Trait;

use App\Models\Driver;

trait Seats {
    public function makeSeatUnavailable(int $driverId, string $seats) : bool {
        $driver = Driver::whereId($driverId)->first();
        $driverSeats = json_decode($driver->seats, true);
        $selectedSeats = json_decode($seats, true);
        if($this->numberOfAvailableSeats($driverSeats) == 0) return false;
        $updatedSeats = array_map(function (array $seat) use ($selectedSeats) {
            if(in_array($seat['seat'], $selectedSeats)){
                $seat['status'] = "selected";
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
}
?>
