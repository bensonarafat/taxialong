<?php
namespace App\Http\Trait;

use App\Models\Wallet;

trait TaxiAlongWallet {

    public function createWallet() : void{
        $exists = Wallet::where("user_id", auth()->user()->id)->exists();
        if(!$exists){
            Wallet::create(["type" => "fund", "name" => "Avaiable Balance", "user_id" => auth()->user()->id]);
            Wallet::create(["type" => "bonus",  "name" => "Bonus Balance", "user_id" => auth()->user()->id]);
        }
    }

    public function availableFund() : int {
        $this->createWallet();
        $wallet  = Wallet::where(["user_id" => auth()->user()->id, "type" => "fund"])->first();
        return $wallet->balance;
    }

    public function availableBonus () : int {
        $wallet  = Wallet::where(["user_id" => auth()->user()->id, "type" => "bonus"])->first();
        return $wallet->balance;
    }

    public function topUp(int $amount, string $type) : void {
        $wallet = Wallet::where(["user_id" =>  auth()->user()->id, "type" => $type ])->first();
        $balance = floatval($wallet->balance) + floatval($amount);
        $wallet->balance = $balance;
        $wallet->save();
    }

    public function withdraw(int $amount, string $type) : bool {
        $wallet = Wallet::where(["user_id" =>  auth()->user()->id, "type" => $type ])->first();
        if(floatval($wallet->balance) >= floatval($amount)){
            $balance = floatval($wallet->balance) - floatval($amount);
            $wallet->balance = $balance;
            $wallet->save();
            return true;
        }else{
            return false;
        }
    }
}
?>
