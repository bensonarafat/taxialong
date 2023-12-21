<?php

namespace App\Http\Controllers;

use App\Http\Trait\TaxiAlongWallet;
use App\Models\RideSettings;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class WalletController extends Controller
{
    use TaxiAlongWallet;

    public function fundWallet(Request $request) : JsonResponse{
        return response()->json();
    }

    public function wallet() : JsonResponse
    {
        return response()->json([
            "status" => true,
            "message" => "Wallet fetched",
            "data" => [
                "bonus" => $this->availableBonus(),
                "fund" => $this->availableFund(),
            ]
            ]);
    }

    public function updatePaymentMethod(Request $request) : JsonResponse
    {
        RideSettings::where('user_id', $request->user()->id)->update(["payment_method" => $request->paymentMethod]);
        return response()->json(["status" => true, "message" => "Payment Method Updated"]);
    }
}
