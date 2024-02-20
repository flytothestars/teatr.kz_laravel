<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTicketsTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('tickets', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('api_id')->nullable()->index();
            $table->foreignId('pricegroup_id')->nullable()->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('timetable_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('section_id')->nullable()->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->string('row',10)->nullable()->index();
            $table->string('seat',10)->nullable()->index();
            $table->foreignId('seat_id')->nullable()->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->unsignedMediumInteger('price')->default(0);
            $table->boolean('blocked')->default(0)->index();
            $table->boolean('sold')->default(0)->index();
            $table->string('barcode',32)->nullable()->index();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('tickets');
    }
}
