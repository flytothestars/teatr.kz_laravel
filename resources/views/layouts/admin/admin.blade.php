<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    @include('parts.admin_assets')
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Админ - {{ env('APP_NAME') }}</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
    <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
    <link rel="manifest" href="/site.webmanifest" crossorigin="use-credentials">
    <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    @yield('head')
</head>
<body class="body body-@yield('body-class','default')">
<div class="wrapper" id="app">
    <sidebar-component></sidebar-component>
    <div class="main-panel">
        <div class="content pb-5">
            @include('layouts.admin.messages')
            <div>
                <router-link to=""></router-link>
            </div>
            <router-view></router-view>
        </div>
        <div class="dropdown-hover-shadow"></div>
        <div class="vue-loader"></div>
        @include('layouts.admin.footer')
    </div>
</div>
</body>
</html>
