<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Axis extends Model
{
    use HasFactory;

    protected $table = 'axis';

    protected $fillable = [
        'point_a',
        'point_b',
        'bus_stop_id',
        'sequence',
    ];
}
