<?php

namespace Database\Seeders;

use App\Models\Terminal;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TerminalSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Terminal::factory()->createMany([
            ['latitude' => 8.9641, 'longitude' => 7.3814, 'name' => 'Lugbe'],
            ['latitude' => 9.0671, 'longitude' => 7.4543, 'name' => 'Berger'],
            ['latitude' => 9.0962, 'longitude' => 7.4442, 'name' => 'Katampe Rd'],
            ['latitude' => 9.1477, 'longitude' => 7.4956, 'name' => 'Mpape'],
            ['latitude' => 9.0267, 'longitude' => 7.6074, 'name' => 'Mararaba'],
            ['latitude' => 8.9508, 'longitude' => 7.0767, 'name' => 'Gwagwalada'],
            ['latitude' => 9.0969, 'longitude' => 7.2228, 'name' => 'Zuba'],
            ['latitude' => 9.1538, 'longitude' => 7.3220, 'name' => 'Kubwa'],
            ['latitude' => 9.1099, 'longitude' => 7.4042, 'name' => 'Gwarinpa'],
            ['latitude' => 9.0503, 'longitude' => 7.3763, 'name' => 'Karmo'],
            ['latitude' => 9.0831, 'longitude' => 7.4482, 'name' => 'Mabushi'],
            ['latitude' => 9.0293, 'longitude' => 7.4801, 'name' => 'Area 3'],
        ]);
    }
}
