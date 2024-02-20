<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEventCastTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('event_cast', function (Blueprint $table) {
            $table->foreignId('event_id')->constrained('events')->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('cast_id')->constrained('cast')->restrictOnDelete()->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('event_cast');
    }
}
