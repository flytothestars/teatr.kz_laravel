<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateMenuItemsTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('menu_items', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->json('title')->nullable();
            $table->string('url')->nullable();
            $table->integer('sort_order')->default(1);
            $table->boolean('header')->default(1)->index();
            $table->boolean('footer1')->default(1)->index();
            $table->boolean('footer2')->default(1)->index();
            $table->boolean('footer3')->default(1)->index();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('menu_items');
    }
}
