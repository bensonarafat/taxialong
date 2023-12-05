<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RideSettings extends Model
{
    use HasFactory;

    protected $fillable = [
        'pointa',
        'pointb',
        'payment_method',
        'ride_class',
        'user_id',
        'driver_id',
    ];
}
