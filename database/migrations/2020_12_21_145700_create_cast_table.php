<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCastTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('cast', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->json('name')->nullable();
            $table->json('description')->nullable();
            $table->unsignedBigInteger('primary_media_id')->nullable();
            $table->foreign('primary_media_id')->references('id')->on('spacemedia')
                ->constrained()
                ->nullOnDelete()
                ->cascadeOnUpdate();
            $table->string('primary_media_ext',4)->nullable();
            $table->boolean('actor')->default(0)->index();
            $table->boolean('director')->default(0)->index();
            $table->boolean('artist')->default(0)->index();
            $table->boolean('active')->default(1)->index();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('cast');
    }
}
