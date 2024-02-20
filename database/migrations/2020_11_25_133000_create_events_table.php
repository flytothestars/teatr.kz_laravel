<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEventsTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('events', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('api_id')->nullable()->index();
            $table->enum('api',['lermontov','gatob','sats'])->nullable()->index();
            $table->json('title')->nullable();
            $table->json('description')->nullable();
            $table->foreignId('category_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('ticket_design_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('organizator_id')->nullable()->constrained('users')->restrictOnDelete()->cascadeOnUpdate();
            $table->unsignedMediumInteger('min_price')->nullable();
            $table->unsignedMediumInteger('max_price')->nullable();
            $table->unsignedSmallInteger('duration')->nullable();
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
        Schema::dropIfExists('events');
    }
}
