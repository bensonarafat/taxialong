<?php

namespace Database\Seeders;

use App\Models\Axis;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class AxisSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Axis::factory()->createMany([
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 1, 'sequence' => 1],
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 2, 'sequence' => 2],
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 3, 'sequence' => 3],
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 4, 'sequence' => 4],
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 5, 'sequence' => 5],
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 6, 'sequence' => 6],
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 7, 'sequence' => 7],
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 8, 'sequence' => 8],
            ['point_a' => 1, 'point_b' => 2, 'bus_stop_id' => 9, 'sequence' => 9],
            #
            ['point_a' => 2, 'point_b' => 3, 'bus_stop_id' => 10, 'sequence' => 1],
            ['point_a' => 2, 'point_b' => 3, 'bus_stop_id' => 11, 'sequence' => 2],
            ['point_a' => 2, 'point_b' => 3, 'bus_stop_id' => 12, 'sequence' => 3],
            ['point_a' => 2, 'point_b' => 3, 'bus_stop_id' => 13, 'sequence' => 4],
            ['point_a' => 2, 'point_b' => 3, 'bus_stop_id' => 14, 'sequence' => 5],
            ['point_a' => 2, 'point_b' => 3, 'bus_stop_id' => 15, 'sequence' => 6],
            ['point_a' => 2, 'point_b' => 3, 'bus_stop_id' => 16, 'sequence' => 7],
            #
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 17, 'sequence' => 1],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 18, 'sequence' => 2],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 19, 'sequence' => 3],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 20, 'sequence' => 4],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 21, 'sequence' => 5],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 22, 'sequence' => 6],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 23, 'sequence' => 7],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 24, 'sequence' => 8],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 25, 'sequence' => 9],
            ['point_a' => 4, 'point_b' => 5, 'bus_stop_id' => 26, 'sequence' => 10],

            #
            ['point_a' => 6, 'point_b' => 7, 'bus_stop_id' => 27, 'sequence' => 1],
            ['point_a' => 6, 'point_b' => 7, 'bus_stop_id' => 28, 'sequence' => 2],
            ['point_a' => 6, 'point_b' => 7, 'bus_stop_id' => 29, 'sequence' => 3],
            ['point_a' => 6, 'point_b' => 7, 'bus_stop_id' => 30, 'sequence' => 4],
            #
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 31, 'sequence' => 1],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 32, 'sequence' => 2],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 33, 'sequence' => 3],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 34, 'sequence' => 4],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 35, 'sequence' => 5],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 36, 'sequence' => 6],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 37, 'sequence' => 7],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 38, 'sequence' => 8],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 39, 'sequence' => 9],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 40, 'sequence' => 10],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 41, 'sequence' => 11],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 42, 'sequence' => 12],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 43, 'sequence' => 13],
            ['point_a' => 7, 'point_b' => 8, 'bus_stop_id' => 44, 'sequence' => 14],
            #
            ['point_a' => 8, 'point_b' => 9, 'bus_stop_id' => 45, 'sequence' => 1],
            ['point_a' => 8, 'point_b' => 9, 'bus_stop_id' => 46, 'sequence' => 2],
            ['point_a' => 8, 'point_b' => 9, 'bus_stop_id' => 47, 'sequence' => 3],
            ['point_a' => 8, 'point_b' => 9, 'bus_stop_id' => 48, 'sequence' => 4],
            ['point_a' => 8, 'point_b' => 9, 'bus_stop_id' => 49, 'sequence' => 5],
            ['point_a' => 8, 'point_b' => 9, 'bus_stop_id' => 50, 'sequence' => 6],
            ['point_a' => 8, 'point_b' => 9, 'bus_stop_id' => 51, 'sequence' => 7],
            ['point_a' => 8, 'point_b' => 9, 'bus_stop_id' => 52, 'sequence' => 8],
            #
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 53, 'sequence' => 1],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 54, 'sequence' => 2],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 55, 'sequence' => 3],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 56, 'sequence' => 4],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 57, 'sequence' => 5],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 58, 'sequence' => 6],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 59, 'sequence' => 7],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 60, 'sequence' => 8],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 61, 'sequence' => 9],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 62, 'sequence' => 10],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 63, 'sequence' => 11],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 64, 'sequence' => 12],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 65, 'sequence' => 13],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 66, 'sequence' => 14],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 67, 'sequence' => 15],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 68, 'sequence' => 16],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 69, 'sequence' => 17],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 70, 'sequence' => 18],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 71, 'sequence' => 19],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 72, 'sequence' => 20],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 73, 'sequence' => 21],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 74, 'sequence' => 22],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 75, 'sequence' => 23],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 76, 'sequence' => 24],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 77, 'sequence' => 25],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 78, 'sequence' => 26],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 79, 'sequence' => 27],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 80, 'sequence' => 28],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 81, 'sequence' => 29],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 82, 'sequence' => 30],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 83, 'sequence' => 31],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 84, 'sequence' => 32],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 85, 'sequence' => 33],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 86, 'sequence' => 34],
            ['point_a' => 10, 'point_b' => 11, 'bus_stop_id' => 87, 'sequence' => 35],
        ]);
    }
}
