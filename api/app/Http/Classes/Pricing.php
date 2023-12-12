<?php
namespace App\Http\Classes;

use InvalidArgumentException;

class Pricing {

    private $classRates = [
        1 => ['baseFare' => 5.00, 'ratePerMeter' => 0.10],
        2 => ['baseFare' => 6.00, 'ratePerMeter' => 0.12],
        3 => ['baseFare' => 7.00, 'ratePerMeter' => 0.15],
        4 => ['baseFare' => 8.00, 'ratePerMeter' => 0.18],
        5 => ['baseFare' => 9.00, 'ratePerMeter' => 0.20],
    ];



    public function calculateFare($distanceInMeters, $classType)
    {
        // Ensure distance is non-negative
        $distanceInMeters = max(0, $distanceInMeters);

        // Check if the provided class type exists
        if (!isset($this->classRates[$classType])) {
            throw new InvalidArgumentException("Invalid class type: $classType");
        }

        // Get the base fare and rate per meter for the specified class type
        $classRate = $this->classRates[$classType];
        $baseFare = $classRate['baseFare'];
        $ratePerMeter = $classRate['ratePerMeter'];

        // Calculate fare
        $fare = $baseFare + ($ratePerMeter * $distanceInMeters);

        return $fare;
    }
}
?>
