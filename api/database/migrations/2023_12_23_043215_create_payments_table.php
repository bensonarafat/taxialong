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
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId("transaction_id")->constrained("transactions");
            $table->foreignId("user_id")->constrained("users");
            $table->string('domain');
            $table->string('status');
            $table->string('reference');
            $table->string('amount');
            $table->string('gateway_response');
            $table->string('channel');
            $table->string('currency');
            $table->string('ip_address');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
