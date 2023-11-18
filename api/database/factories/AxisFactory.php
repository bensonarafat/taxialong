<?php

namespace Database\Factories;

use App\Models\Axis;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Axis>
 */
class AxisFactory extends Factory
{

    protected $model = Axis::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'point_a' => 1,
            'point_b' => 2,
            'bus_stop_id' => 1,
            'sequence' => 1,
        ];
    }
}
