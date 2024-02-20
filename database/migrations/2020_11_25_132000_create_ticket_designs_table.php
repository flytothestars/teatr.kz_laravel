<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTicketDesignsTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('ticket_designs', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('title');
            $table->boolean('title_exists')->default(1);
            $table->smallInteger('title_l')->default(0);
            $table->smallInteger('title_r')->default(0);
            $table->smallInteger('title_t')->default(0);
            $table->boolean('date_exists')->default(1);
            $table->smallInteger('date_l')->default(0);
            $table->smallInteger('date_r')->default(0);
            $table->smallInteger('date_t')->default(0);
            $table->boolean('section_exists')->default(1);
            $table->smallInteger('section_l')->default(0);
            $table->smallInteger('section_r')->default(0);
            $table->smallInteger('section_t')->default(0);
            $table->boolean('row_exists')->default(1);
            $table->smallInteger('row_l')->default(0);
            $table->smallInteger('row_r')->default(0);
            $table->smallInteger('row_t')->default(0);
            $table->boolean('seat_exists')->default(1);
            $table->smallInteger('seat_l')->default(0);
            $table->smallInteger('seat_r')->default(0);
            $table->smallInteger('seat_t')->default(0);
            $table->boolean('barcode_exists')->default(1);
            $table->smallInteger('barcode_l')->default(0);
            $table->smallInteger('barcode_r')->default(0);
            $table->smallInteger('barcode_t')->default(0);
            $table->boolean('qr_exists')->default(1);
            $table->smallInteger('qr_l')->default(0);
            $table->smallInteger('qr_r')->default(0);
            $table->smallInteger('qr_t')->default(0);
            $table->boolean('ticketn_exists')->default(1);
            $table->smallInteger('ticketn_l')->default(0);
            $table->smallInteger('ticketn_r')->default(0);
            $table->smallInteger('ticketn_t')->default(0);
            $table->boolean('price_exists')->default(1);
            $table->smallInteger('price_l')->default(0);
            $table->smallInteger('price_r')->default(0);
            $table->smallInteger('price_t')->default(0);
            $table->boolean('order_exists')->default(1);
            $table->smallInteger('order_l')->default(0);
            $table->smallInteger('order_r')->default(0);
            $table->smallInteger('order_t')->default(0);
            $table->boolean('user_exists')->default(1);
            $table->smallInteger('user_l')->default(0);
            $table->smallInteger('user_r')->default(0);
            $table->smallInteger('user_t')->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('ticket_designs');
    }
}
