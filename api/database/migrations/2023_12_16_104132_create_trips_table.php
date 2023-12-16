<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('trips', function (Blueprint $table) {
            $table->id();
            $table->foreignId("rider_id")->constrained("users");
            $table->foreignId("driver_id")->constrained("users");
            $table->foreignId("pointa")->constrained("bus_stops");
            $table->foreignId("pointb")->constrained("bus_stops");
            $table->enum("payment_method", ["cash", "wallet"])->default("cash");
            $table->decimal('amount', 10, 2);
            $table->integer("trip_class")->default(1);
            $table->json("seats")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('trips');
    }
};
