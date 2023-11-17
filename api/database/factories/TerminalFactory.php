<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Terminal>
 */
class TerminalFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'latitude' => $this->faker->randomFloat(6, 8.98820, 9.06623),
            'longitude' => $this->faker->randomFloat(6, 7.39454, 7.45479),
            'name' => $this->faker->unique()->word,
        ];
    }
}
