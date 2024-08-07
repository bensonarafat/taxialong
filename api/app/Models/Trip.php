<?php

namespace App\Models;

use App\Models\Car;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Trip extends Model
{
    use HasFactory;

    protected $fillable = [
        'rider_id',
        'driver_id',
        'car_id',
        'pointa',
        'pointb',
        'payment_method',
        'amount',
        'ride_class',
        'seats',
        'reason',
    ];


    public function driver() : HasOne
    {
        return $this->hasOne(User::class, 'id', "driver_id");
    }


    public function tripDriver() : HasOne
    {
        return $this->hasOne(Driver::class, 'user_id', "driver_id");
    }

    public function rider() : HasOne
    {
        return $this->hasOne(User::class, "id", "rider_id");
    }

    public function location() : HasOne
    {
        return $this->hasOne(Driver::class, "user_id", "driver_id");
    }

    public function reviews() : HasMany
    {
        return $this->hasMany(Review::class, "driver_id", "driver_id");
    }

    public function pointa() : HasOne
    {
        return $this->hasOne(BusStop::class, "id", "pointa");
    }
    public function pointb() : HasOne
    {
        return $this->hasOne(BusStop::class, "id", "pointb");
    }

    public function car() : HasOne
    {
        return $this->hasOne(Car::class, "id", "car_id");
    }
}
