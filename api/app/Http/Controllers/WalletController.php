<?php

namespace App\Http\Controllers;

use App\Http\Trait\TaxiAlongTransaction;
use GuzzleHttp\Client;
use App\Models\RideSettings;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Trait\TaxiAlongWallet;
use App\Models\Payment;
use App\Models\Transaction;

class WalletController extends Controller
{
    use TaxiAlongWallet, TaxiAlongTransaction;

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

    public function  verifyPayment(string $reference) : JsonResponse
    {
        $client = new Client();
        $response = $client->request("GET", "https://api.paystack.co/transaction/verify/{$reference}", [
            "headers" => [
                "Authorization" => 'Bearer sk_test_8e6cf8a8d90cd1bd6e29d5616ef7daf1a30b0c21',
                "Accept" => 'application/json',
            ]
            ]);
        if($response->getStatusCode() == 200){
            $body = $response->getBody()->getContents();
            $content = json_decode($body, true);
            if($content['status']){
                $this->topUp($content['data']['amount'], "fund");
                $transaction = $this->createTransaction($content['data']['amount'], "credit", "Top up");
                $this->createPayment($transaction, $content['data']);
                return response()->json(["status" => true, "message" => "Payment sucessful", "amount" => $content['data']['amount']]);
            }else{
                return response()->json(["status" => false, "message" => "Payment failed"]);
            }
        }
    }


    private function createPayment(Transaction $transaction, array $content) :void
    {
        Payment::create([
            "user_id" => auth()->user()->id,
            "transaction_id" => $transaction->id,
            "domain" => $content['domain'],
            "status" => $content['status'],
            "reference" => $content['reference'],
            "amount" => $content['amount'],
            "gateway_response" => $content['gateway_response'],
            'channel' => $content['channel'],
            'currency' => $content['currency'],
            'ip_address' => $content['ip_address'],
        ]);
    }
}
