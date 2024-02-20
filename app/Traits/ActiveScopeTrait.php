<?php

namespace App\Traits;

trait ActiveScopeTrait {

    public function scopeActive($query) {
        return $query->where('active', 1);
    }

}
