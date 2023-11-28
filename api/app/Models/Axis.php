<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Axis extends Model
{
    use HasFactory;

    protected $table = 'axis';

    protected $fillable = [
        'point_a',
        'point_b',
        'bus_stop_id',
        'sequence',
    ];


    public function terminalA() : BelongsTo {
        return $this->belongsTo(Terminal::class, "point_a");
    }

    public function terminalB() : BelongsTo {
        return $this->belongsTo(Terminal::class, "point_b");
    }

    public function busStop() : BelongsTo {
        return $this->belongsTo(BusStop::class, "bus_stop_id");
    }
}
