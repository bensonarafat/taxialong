<?php

namespace App\Http\Controllers;

use App\Http\Trait\TaxiAlongWallet;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class WalletController extends Controller
{
    use TaxiAlongWallet;

    public function fundWallet(Request $request) : JsonResponse{
        return response()->json();
    }
}
