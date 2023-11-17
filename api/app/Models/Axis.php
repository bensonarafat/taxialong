<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Axis extends Model
{
    use HasFactory;

    protected $table = 'axes';

    protected $fillable = [
        'driver_id',
        'from',
        'to',
    ];
}
