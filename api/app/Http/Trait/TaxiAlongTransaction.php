<?php
namespace App\Http\Trait;

use App\Models\Transaction;
use Illuminate\Http\Request;

trait TaxiAlongTransaction{

    public function createTransaction(string $amount, string $type, string $description) : Transaction
     {
       return Transaction::create([
            "user_id" => auth()->user()->id,
            "type" => $type,
            "amount" => $amount,
            "description" => $description,
        ]);
    }
}
?>
