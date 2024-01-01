<?php

namespace App\Listeners;

use App\Models\Trip;
use App\Events\TripEvent;
use App\Events\NotificationEvent;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class TripListener
{


    /**
     * Handle the event.
     */
    public function handle(TripEvent $event): void
    {
        $trip = $event->trip;
        $title = $this->getTitle($trip->status);;
        $message = $this->getMessage($trip);
        if($trip->driver_id == auth()->user()->id){
            NotificationEvent::dispatch($trip->driver_id, $title, $message);
        }else{
            NotificationEvent::dispatch($trip->rider_id, $title, $message);
        }
    }

    private function getTitle(string $status) : string
    {
        if($status == "pickedup"){
            return "Pick Up";
        }else if($status == "completed"){
            return "Trip Completed";
        }else if($status == "canceled"){
            return "Trip Canceled";
        }else if($status == "requested"){
            return "New Trip Request";
        }else if($status == ""){
            return "Nothing happening here";
        }
    }

    private function getMessage(Trip $trip) : string
    {
        if($trip->status == "pickedup"){
            return "New Pick Up";
        }else if($trip->status == "completed"){
            return "Trip ended and completed";
        }else if($trip->status == "canceled"){
            return $trip->reason;
        }else if($trip->status == "requested"){
            return "New Trip Request";
        }else if($trip->status == ""){
            return "Nothing happening here";
        }
    }
}
