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
        Schema::create('ride_settings', function (Blueprint $table) {
            $table->id();
            $table->foreignId("user_id")->constrained('users')->onDelete('cascade');
            $table->foreignId("driver_id")->constrained("drivers")->onDelete('cascade');
            $table->foreignId("pointa")->constrained("bus_stops")->nullable();
            $table->foreignId("pointb")->constrained("bus_stops")->nullable();
            $table->enum("payment_method", ["cash", "wallet"])->default("cash");
            $table->json("ride_class")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ride_settings');
    }
};
