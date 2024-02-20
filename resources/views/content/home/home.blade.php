@extends('layouts.app')

@section('head')
    <link rel="stylesheet" href="/css/swiper-bundle.min.css">
@endsection

@section('body-class', 'home')

@section('content')

    @include('content.home.home__events')

{{--    @include('content.home.home__venues')--}}

{{--    @include('content.home.home__feedbacks')--}}

{{--    @include('content.home.home__news')--}}

@endsection

@section('footer')
    <script src="/js/swiper-bundle.min.js"></script>
@endsection
