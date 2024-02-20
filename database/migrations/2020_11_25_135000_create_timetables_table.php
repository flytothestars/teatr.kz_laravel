<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTimetablesTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('timetables', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('api_id')->nullable()->index();
            $table->enum('api',['lermontov','gatob','sats'])->nullable()->index();
            $table->foreignId('event_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('venue_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('venue_scheme_id')->nullable()->constrained('venue_schemes')->restrictOnDelete()->cascadeOnUpdate();
            $table->dateTime('datetime')->nullable()->index();
            $table->enum('type',['sections','pricegroups'])->default('sections');
            $table->json('note')->nullable();
            $table->boolean('active')->default(1)->index();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('timetables');
    }
}
