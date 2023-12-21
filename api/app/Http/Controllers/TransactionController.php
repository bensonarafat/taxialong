<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class TransactionController extends Controller
{
    const PER_PAGE = 10;
    const PAGE = 1;

    public function transactions() : JsonResponse
    {
        $perPage = request()->input("perPage", self::PER_PAGE );
        $page = request()->input("page", self::PAGE);

        $transactions = Transaction::where('user_id', auth()->user()->id)->latest()
                        ->skip(($page - 1) * $perPage)
                        ->take($perPage)
                        ->get();

        return response()->json([
            "status" => true,
            "message" => "Transactions fetched",
            "data" => $transactions
        ]);
    }
}
