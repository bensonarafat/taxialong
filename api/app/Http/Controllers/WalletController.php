<?php

namespace App\Http\Controllers;

use GuzzleHttp\Client;
use App\Models\RideSettings;
use Illuminate\Http\Request;
use App\Trait\TaxiAlongWallet;
use App\Events\TransactionEvent;
use Illuminate\Http\JsonResponse;

class WalletController extends Controller
{
    use TaxiAlongWallet;

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
                $amount = intval($content['data']['amount']) / 100;
                $this->topUp($amount, "fund");
                $content['message'] = "You have successfully top up your account with NGN$amount";
                $content['amount'] = $amount;
                $content['title'] = 'Wallet Topup Successful!';
                $content['userId'] = auth()->user()->id;
                TransactionEvent::dispatch($content);
                return response()->json(["status" => true, "message" => "Payment sucessful", "amount" => $amount]);
            }else{
                return response()->json(["status" => false, "message" => "Payment failed"]);
            }
        }
    }


}
