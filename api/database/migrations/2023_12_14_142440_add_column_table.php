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
        Schema::table('drivers', function (Blueprint $table) {
            $seats = [ [ "seat" => 1, "available" => true, ], [ "seat" => 2, "available" => true, ], [ "seat" => 3, "available" => true, ], [ "seat" => 4, "available" => true, ],["seat" => 5,"available" => true, ], [ "seat" => 6, "available" => true, ],];
            $table->json("seats")->default(json_encode($seats));
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('drivers', function (Blueprint $table) {
            //
        });
    }
};
