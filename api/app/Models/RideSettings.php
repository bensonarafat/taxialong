<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class RideSettings extends Model
{
    use HasFactory;

    protected $fillable = [
        'pointa',
        'pointb',
        'payment_method',
        'user_id',
        'driver_id',
    ];


    public function origin() : HasOne {
        return $this->hasOne(Terminal::class, 'id', 'pointa');
    }

    public function destination() : HasOne {
        return $this->hasOne(Terminal::class, 'id', 'pointb');
    }
}
