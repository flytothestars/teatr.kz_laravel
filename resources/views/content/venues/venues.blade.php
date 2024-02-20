@php
    $current_city = session('city', env('DEFAULT_CITY'));
@endphp

@extends('layouts.app')

@section('content')
    {{ Breadcrumbs::render('theatres') }}
    <div class="container mob-container">
        <div class="narrow-content">
            <h1 id="page-title">Театры, {{ $city->title }}</h1>
            @foreach($venues as $d)
                @include('teasers.teaser__venue_page')
            @endforeach
        </div>
        {!! $venues->links() !!}
        <div class="bottom-space"></div>
    </div>
@endsection
