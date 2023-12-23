<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
    use HasFactory;

    protected $fillable = [
        'driver_id',
        'rider_id',
        'trip_id',
        'rating',
        'comment',
    ];
}
