<?php

namespace App\Models;

use App\Models\User;
use App\Models\Earning;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Driver extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'online',
        'latitude',
        'longitude',
        'seats',
    ];

    public function settings () : HasOne {
        return $this->hasOne(RideSettings::class);
    }
    public function total_rides(): HasMany {
        return $this->hasMany(Trip::class, "driver_id", "user_id")->where('status', "completed");
    }

    public function today_ride() : HasMany {
        return $this->hasMany(Trip::class, "driver_id", "user_id")->where('status', "completed");
    }

    public function earnings() : HasMany
    {
        return $this->hasMany(Earning::class, "user_id", "user_id");
    }
}
