<?php

namespace App\Listeners;

use App\Events\NotificationEvent;
use App\Models\Payment;
use App\Models\Transaction;
use App\Events\TransactionEvent;
use App\Trait\TaxiAlongTransaction;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class TransactionListener
{

    use TaxiAlongTransaction;
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(TransactionEvent $event): void
    {
        $transaction = $this->createTransaction($event->content['amount'], "credit", "Top up");
        $this->createPayment($transaction, $event->content);
        NotificationEvent::dispatch($event->content['userId'], $event->content['title'], $event->content['message']);
    }

    private function createPayment(Transaction $transaction, array $content) :void
    {
        Payment::create([
            "user_id" => $content['userId'],
            "transaction_id" => $transaction->id,
            "domain" => $content['data']['domain'],
            "status" => $content['data']['status'],
            "reference" => $content['data']['reference'],
            "amount" => intval($content['data']['amount']) / 100,
            "gateway_response" => $content['data']['gateway_response'],
            'channel' => $content['data']['channel'],
            'currency' => $content['data']['currency'],
            'ip_address' => $content['data']['ip_address'],
        ]);
    }
}
