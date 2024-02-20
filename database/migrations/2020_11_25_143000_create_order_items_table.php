<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateOrderItemsTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('order_items', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->foreignId('order_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('timetable_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('section_id')->nullable()->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('pricegroup_id')->nullable()->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->foreignId('ticket_id')->nullable()->constrained()->nullOnDelete()->cascadeOnUpdate();
            $table->string('row',10)->nullable()->index();
            $table->string('seat',10)->nullable()->index();
            $table->unsignedMediumInteger('price')->default(0);
            $table->string('barcode',64)->nullable()->index();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('order_items');
    }
}
