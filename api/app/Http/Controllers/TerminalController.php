<?php

namespace App\Http\Controllers;

use App\Models\BusStop;
use Illuminate\Http\Request;

class TerminalController extends Controller
{
    public function terminals(Request $request){
        $busStops = BusStop::latest()->get();
        //calculate distances to each bus stop
        $distances = [];
        foreach ($busStops as $row) {
            $distances[$row->id] = $this->calculatteDistance($request->latitude, $request->longitude, $row->latitude, $row->longitude);
        }

        // find the bus stop with the minum distance
        $nearestBusStopId = array_keys($distances,  min($distances))[0];
        $nearestBusStop = BusStop::find($nearestBusStopId);
        return response()->json([$nearestBusStop]);
    }

    protected function calculateDistance($lat1, $long1, $lat2, $long2){
        $earthRadius = 6371; // Radius of the Earth in kilometers

        $dlat = deg2rad($lat2 - $lat1);
        $dlon = deg2rad($long2 - $long1);

        $a = sin($dlat / 2) * sin($dlat / 2) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dlon / 2) * sin($dlon / 2);
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));

        $distance = $earthRadius * $c;

        return $distance;
    }
}
