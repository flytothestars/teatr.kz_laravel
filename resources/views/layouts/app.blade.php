@php
    $full = !(isset($min) && $min);
    $mode = isset($dark) && $dark ? 'dark' : 'standard';
@endphp

<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    @include('parts.meta-title')
    @include('parts.metrika')
    @include('parts.assets')
    @yield('head')
</head>
<body id="body" class="body body-@yield('body-class','default')">
@if($full)
    @include('layouts.header', ['mode' => $mode])
    @include('parts.mobile_menu')
@endif
<main>
    @yield('content')
</main>
@include('parts.login-popup')
<div class="vue-loader"></div>
@if($full)
    @include('content.home.home__subscribe')
    @include('parts.search')
    @include('layouts.footer')
@endif
@yield('footer')
</body>
</html>
