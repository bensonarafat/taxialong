<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BusStop extends Model
{

    protected $table = "bus_stops";

    use HasFactory;

    protected $fillable = [
        'latitude',
        'longitude',
        'name',
        'terminal_id'
    ];
}
