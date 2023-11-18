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
        Schema::create('axis', function (Blueprint $table) {
            $table->id();
            $table->foreignId("point_a")->constrained('terminals');
            $table->foreignId("point_b")->constrained('terminals');
            $table->foreignId("bus_stop_id")->constrained('bus_stops');
            $table->integer('sequence');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('axis');
    }
};
