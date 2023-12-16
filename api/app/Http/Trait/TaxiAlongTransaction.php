<?php
namespace App\Http\Trait;

use App\Models\Transaction;
use Illuminate\Http\Request;

trait TaxiAlongTransaction{

    public function createTransaction(Request $request, string $type) : void {
        Transaction::create([
            "user_id" => auth()->user()->id,
            "type" => $type,
            "amount" => $request->amount,
        ]);
    }
}
?>
