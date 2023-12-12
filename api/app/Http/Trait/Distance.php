<?php
namespace App\Http\Trait;

use App\Models\Price;
use Exception;
use App\Http\Classes\Pricing;

trait Distance  {

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

    /**
     * @param int Ride Class
     * @param array Pickup Bus Stop
     * @param array Drop Off Bus Stop
     *
     * @return int|bool amount | false
     */
    public function calculatePrice($rideClass, $pickUpBusStop, $dropOffBusStop) : int | bool
    {
        $exists = Price::where(
                                [
                                    "pointa" => $pickUpBusStop['busstop'],
                                    "pointb" => $dropOffBusStop['busstop'],
                                ])->exists();
        if($exists){
           $price =  Price::where([
                "pointa" => $pickUpBusStop['busstop'],
                "pointb" => $dropOffBusStop['busstop'],
            ])->first();
            $prices = json_decode($price->prices, true);
            $price = $this->searchClass($prices, $rideClass);
            if(!$price){
                /**
                 * check if the price for this ride class is found, if not use the default pricing module i.e google matric
                 */
                $price = $this->googleMatrixPrice($rideClass, $pickUpBusStop, $dropOffBusStop);
                if(!$price){
                    return false;
                }
            }
            return $price;
        }else{
            $price = $this->googleMatrixPrice($rideClass, $pickUpBusStop, $dropOffBusStop);
            if(!$price){
                return false;
            }
            return $price;

        }
    }

    /**
     * @param int Ride Class
     * @param array Pickup Bus Stop
     * @param array Drop Off Bus Stop
     *
     * @return int|bool amount | false
     */
    private function googleMatrixPrice($rideClass, $pickUpBusStop, $dropOffBusStop) : int | bool
    {
        try {
            $response = \GoogleMaps::load('distancematrix')
                    ->setParamByKey('origins', $pickUpBusStop['latitude'].",".$pickUpBusStop['longitude'])
                    ->setParamByKey('destinations', $dropOffBusStop['latitude'].",".$dropOffBusStop['longitude'])
                    ->getResponseByKey("rows.elements.distance");
            // distance in meters
            $distancemeters = $response['rows'][0]['elements'][0]['distance']['value'];
            //calculate price with meters
            $taxiPricing = new Pricing();
            $fare = $taxiPricing->calculateFare($distancemeters, $rideClass);
            return $fare;
        } catch (Exception $e) {
            return false;
        }

    }

    private function searchClass($classes, $classId) : float | bool  {
        $keys = array_column($classes, "class");
        $index = array_search($classId, $keys);
        return $index !== false ? $classes[$index]['amount'] : false;
    }
}
?>
