<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->foreignId('timetable_id')->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->enum('api',['lermontov','gatob','sats'])->nullable()->index();
            $table->foreignId('user_id')->nullable()->constrained()->restrictOnDelete()->cascadeOnUpdate();
            $table->string('name',100)->nullable();
            $table->string('email',100)->nullable();
            $table->string('phone',30)->nullable();
            $table->text('comment')->nullable();
            $table->unsignedMediumInteger('price')->default(0);
            $table->string('pay_id',40)->nullable();
            $table->unsignedMediumInteger('pay_sum')->default(0);
            $table->dateTime('pay_date')->nullable();
            $table->enum('pay_system',['cash','card'])->nullable();
            $table->string('pay_url',200)->nullable();
            $table->string('hash',32)->nullable()->index();
            $table->ipAddress('ip');
            $table->boolean('paid')->default(0)->index();
            $table->boolean('sent')->default(0)->index();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
