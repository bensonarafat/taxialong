<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class BusStop extends Model
{

    protected $table = "bus_stops";

    use HasFactory;

    protected $fillable = [
        'latitude',
        'longitude',
        'name',
    ];

    public function axis() : HasMany
    {
        return $this->hasMany(Axis::class, 'bus_stop_id');
    }
}
