<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'transaction_id',
        'domain',
        'status',
        'reference',
        'amount',
        'gateway_response',
        'channel',
        'currency',
        'ip_address'
    ];
}
