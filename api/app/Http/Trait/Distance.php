<?php
namespace App\Http\Trait;

trait Distance {

     function isPointClosest($request, $axisData) {
        $distanceA = $this->calculateDistance($request->latitude, $request->longitude, $axisData->first()->terminalA->latitude, $axisData->first()->terminalA->longitude);

        $distanceB = $this->calculateDistance($request->latitude, $request->longitude, $axisData->first()->terminalB->latitude, $axisData->first()->terminalB->longitude);

        return $distanceA > $distanceB;
    }
     function calculateDistance($lat1, $long1, $lat2, $long2){
        $earthRadius = 6371; // Radius of the Earth in kilometers

        $dlat = deg2rad($lat2 - $lat1);
        $dlon = deg2rad($long2 - $long1);

        $a = sin($dlat / 2) * sin($dlat / 2) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dlon / 2) * sin($dlon / 2);
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));

        $distance = $earthRadius * $c;

        return $distance;
    }

}
?>
