@extends('layouts.app')

@section('content')
    <section class="search page">
        {{ Breadcrumbs::render('search') }}
        <div class="container">
            <h1 id="page-title">Поиск: {{ Request::get('q') }}</h1>
            <div class="row" id="ssr-events">
                @foreach($events as $d)
                    <div class="col-lg-4 mb-3">
                        @include('teasers.teaser__event')
                    </div>
                @endforeach
            </div>
        </div>
        <div class="bottom-space"></div>
    </section>
@endsection
