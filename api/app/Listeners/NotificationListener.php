<?php

namespace App\Listeners;

use App\Events\NotificationEvent;
use App\Models\Notification;

class NotificationListener
{


    /**
     * Handle the event.
     */
    public function handle(NotificationEvent $event): void
    {
        Notification::create([
            "user_id" => $event->userId,
            "title" => $event->title,
            "content" => $event->message,
        ]);
    }
}
