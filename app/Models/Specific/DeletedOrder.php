<?php

namespace App\Models\Specific;
use Illuminate\Database\Eloquent\Builder;

class DeletedOrder extends Order {

    protected static function boot() {
        static::addGlobalScope('deleted', function (Builder $builder) {
            $builder->onlyTrashed();
        });
    }

}
