<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddPrimaryImageColumns extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('venues', function (Blueprint $table) {
            $table->unsignedBigInteger('primary_media_id')->nullable()->after('city_id');
            $table->foreign('primary_media_id')->references('id')->on('spacemedia')
                ->constrained()
                ->nullOnDelete()
                ->cascadeOnUpdate();
        });

        Schema::table('venues', function (Blueprint $table) {
            $table->string('primary_media_ext',4)->nullable()->after('primary_media_id');
        });

        Schema::table('events', function (Blueprint $table) {
            $table->unsignedBigInteger('primary_media_id')->after('duration')->nullable();
            $table->foreign('primary_media_id')->references('id')->on('spacemedia')
                ->constrained()
                ->nullOnDelete()
                ->cascadeOnUpdate();
        });

        Schema::table('events', function (Blueprint $table) {
            $table->string('primary_media_ext',4)->nullable()->after('primary_media_id');
            $table->string('slug',200)->nullable()->index()->unique()->after('duration');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::table('venues', function (Blueprint $table) {
            $table->dropColumn('primary_media_id');
            $table->dropColumn('primary_media_ext');
        });

        Schema::table('events', function (Blueprint $table) {
            $table->dropColumn('primary_media_id');
            $table->dropColumn('primary_media_ext');
            $table->dropColumn('slug');
        });
    }
}
