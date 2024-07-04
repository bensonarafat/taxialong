<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Car extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'seatId',
        'color',
        'plate_number',
        'model',
        'status',
        'default',
        'driver_id',
        'seats',
        'total',
        'classes',
    ];
}