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
        Schema::create('cars', function (Blueprint $table) {
            $table->id();
            $table->foreignId("user_id")->constrained("users")->onDelete('cascade');
            $table->integer("seatId")->default(1);
            $table->string("color");
            $table->string("plate_number");
            $table->string("model");
            $table->integer("status")->default(1);
            $table->integer("default")->default(0);
            $table->foreignId("driver_id")->nullable()->constrained("drivers")->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cars');
    }
};
