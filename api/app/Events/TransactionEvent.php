<?php

namespace App\Events;

use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class TransactionEvent
{
    use Dispatchable, InteractsWithSockets, SerializesModels;



    public array $content;

    /**
     * Create a new event instance.
     */
    public function __construct( array $content)
    {

        $this->content = $content;
    }
}
