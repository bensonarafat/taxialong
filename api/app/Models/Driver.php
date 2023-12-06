<?php

namespace App\Models;

use App\Models\Earning;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Driver extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'online',
        'latitude',
        'longitude',
    ];


    public function user() : BelongsTo {
        return $this->belongsTo(User::class);
    }

    public function total_rides(): HasMany {
        return $this->hasMany(Trip::class, "driver_id", "user_id");
    }

    public function today_ride() : HasMany {
        return $this->hasMany(Trip::class, "driver_id", "user_id");
    }

    public function earnings() : HasMany
    {
        return $this->hasMany(Earning::class, "user_id", "user_id");
    }
}
