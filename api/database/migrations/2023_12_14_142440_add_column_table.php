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
            $seats = [ [ "seat" => 1, "status" => 'available', ], [ "seat" => 2, "status" => 'available', ], [ "seat" => 3, "status" => 'available', ], [ "seat" => 4, "status" => 'available', ],["seat" => 5,"status" => 'available', ], [ "seat" => 6, "status" => 'available', ],];
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
