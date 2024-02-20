<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePricegroupsTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('pricegroups', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->json('title')->nullable();
            $table->unsignedBigInteger('api_id')->nullable()->index();
            $table->foreignId('timetable_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->unsignedMediumInteger('price')->default(0);
            $table->integer('sort_order')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('pricegroups');
    }
}
