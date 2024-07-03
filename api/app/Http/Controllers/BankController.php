<?php

namespace App\Http\Controllers;

use App\Models\Bank;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class BankController extends Controller
{
    public function create(Request $request) {
        try {
            Bank::create([
                "user_id" => auth()->user()->id,
                "bank" => $request->bank,
                "account_number" => $request->account_number,
                "account_name" => $request->account_name,
            ]);
            return response()->json(["status" => true, "message" => "success"] );
        } catch (Exception $e) {
           return response()->json([
            "status" => false,
            "message" => "Oops, there was an error"
           ]);
        }
    }

    public function update(Request $request, int $id) {
        try {
            Bank::whereId($id)->update([
                "bank" => $request->bank,
                "account_number" => $request->account_number,
                "account_name" => $request->account_name,
            ]);
            return response()->json(["status" => true, "message" => "success"] );
        } catch (Exception $e) {
           return response()->json([
            "status" => false,
            "message" => "Oops, there was an error"
           ]);
        }
    }

    public function get() : JsonResponse
    {
        $bank = Bank::where("user_id", auth()->user()->id)->first();
        return response()->json([
            "status" => true,
            "data" => $bank,
        ]);
    }
}
