<?php

namespace App\Providers;

use App\Events\TripEvent;
use App\Listeners\TripListener;
use App\Events\TransactionEvent;
use App\Events\NotificationEvent;
use App\Events\LocationUpdateEvent;
use App\Events\UpdateTripStatusEvent;
use App\Listeners\TransactionListener;
use Illuminate\Auth\Events\Registered;
use App\Listeners\NotificationListener;
use App\Listeners\LocationUpdateListener;
use App\Listeners\UpdateTripStatusListener;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event to listener mappings for the application.
     *
     * @var array<class-string, array<int, class-string>>
     */
    protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
        NotificationEvent::class => [
            NotificationListener::class,
        ],
        LocationUpdateEvent::class => [
            LocationUpdateListener::class,
        ],
        TripEvent::class => [
            TripListener::class
        ],
        TransactionEvent::class =>[
            TransactionListener::class,
        ]
    ];

    /**
     * Register any events for your application.
     */
    public function boot(): void
    {
        //
    }

    /**
     * Determine if events and listeners should be automatically discovered.
     */
    public function shouldDiscoverEvents(): bool
    {
        return false;
    }
}
