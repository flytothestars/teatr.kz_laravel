@php
    $cities = \App\Models\Specific\City::all();
    $current_city = session('city', env('DEFAULT_CITY'));
    $hmenu = \App\Models\General\MenuItem::getMenu();
@endphp
<?php

?>

<header class="header {{ $mode }}">
    <div class="container mob-container h-100">
        <div class="row h-100 align-items-center">
            <div class="col-3 d-block d-md-none">
                <a class="mob-menu-toggler">
                    <img src="/images/menu{{ $mode == 'dark' ? '_w' : '' }}.svg" alt="меню"/>
                </a>
            </div>
            <div class="col-md-auto col-6">
                <a class="header__logo" @if(Request::path() != '/') href="/" @endif>
                    <img src="/images/{{ $mode == 'dark' ? 'logo_w' : 'logo' }}.svg" alt="лого"/>
                </a>
            </div>
            <div class="col text-center d-md-block d-none">
                @foreach($hmenu as $m)
                    @if($m->header)
                        @if(in_array($m->url,['/'.Request::path(), Request::path()]))
                            <span class="header__link active" >{{ $m->title }}</span>
                        @else
                            <a class="header__link " href="{{ $m->url }}">{{ $m->title }}</a>
                        @endif
                    @endif
                @endforeach
            </div>
            <div class="col-md-auto col-3 d-flex align-items-center justify-content-end">
                <a id="search-header" class="pointer">
                    <img src="/images/search.svg" @if($mode === 'dark') class="svg-filter-white" @endif alt="Поиск" title="Поиск"/>
                </a>
                <div class="ml-4 city-select-wrapper d-md-block d-none">
                    <button type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        @foreach($cities as $city)
                            @if($city->id == $current_city) {{ $city->title }} @endif
                        @endforeach
                        <img src="/images/@if($mode === 'dark'){{ 'down_w.svg' }} @else{{ 'down.svg' }} @endif" class="ml-1" alt="select"/>
                    </button>
                    <div class="dropdown-menu">
                        @foreach($cities as $city)
                            <a class="dropdown-item city-select pointer" data-city="{{ $city->id }}">{{ $city->title }}</a>
                        @endforeach
                    </div>
                </div>
                <div class="d-md-block d-none">
                    @if(Auth::guest())
                        <a data-toggle="modal" data-target="#loginModal" class="btn-plain ml-4 pointer">Войти</a>
                    @else
                        <div class="dropdown profile-dropdown">
                            <button type="button" data-toggle="dropdown" class="btn-plain ml-4" id="dropdownProfile" aria-haspopup="true" aria-expanded="false">
                                {{ Auth::user()->name ? \Illuminate\Support\Str::limit(Auth::user()->name, 10, '...') : 'Профиль' }}
                            </button>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownProfile">
                                <a href="/profile/tickets" class="dropdown-item profile-item pointer">Мои билеты</a>
                                <a href="/profile" class="dropdown-item profile-item pointer">Профиль</a>
                                <hr class="my-2">
                                <form action="/logout" method="post">
                                    @csrf
                                    <button class="dropdown-item profile-item">Выйти</button>
                                </form>
                            </div>
                        </div>
                    @endif
                </div>
            </div>
        </div>

    </div>
</header>
