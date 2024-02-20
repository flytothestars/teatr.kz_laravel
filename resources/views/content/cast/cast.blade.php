@extends('layouts.app')

@section('head')
    <link rel="stylesheet" href="/css/jquery.fancybox.min.css">
@endsection

@section('body-class', 'cast')

@section('content')
    <section class="cast page">
        {{ Breadcrumbs::render('cast', $cast) }}
        <div class="cast__intro">
            <div class="container mob-container">
                <div class="row">
                    <div class="col-auto">
                        <div class="cast__image">
                            <img src="{{ $cast->imagePrimarySrc('main') }}" alt="{{ $cast->name }}" title="{{ $cast->name }}"/>
                        </div>
                    </div>
                    <div class="col mt-md-0 mt-4">
                        <h1 id="page-title">{{ $cast->name }}</h1>
                        <div class="row">
                            <div class="col-md">
                                <div class="pr-md-5">
                                    <article>{!! $cast->description !!}</article>
                                </div>
                            </div>
                            <div class="col-md-auto mt-md-0 mt-3">
                                @include('parts.share')
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        @if(count($media) > 1)
            <div class="cast__gallery">
                <div class="container mob-container">
                    <div id="masonry-grid" >
                        @foreach($media as $m)
                            @if(!$loop->first)
                                <a href="{{ $m->getUrl('main') }}" data-fancybox="gallery" class="d-inline-block">
                                    <img src="{{ $m->getUrl('main') }}" class="grid-item img" alt="{{ $cast->name }}"/>
                                </a>
                            @endif
                        @endforeach
                    </div>
                </div>
            </div>
        @endif

        @if($timetables && count($timetables) > 0)
            <div class="cast__schedule" id="schedule">
                <div class="container mob-container">
                    <div class="narrow-content">
                        <h2>Спектакли с участием актера</h2>
                        @foreach($timetables as $d)
                            @include('teasers.teaser__timetable')
                        @endforeach
                    </div>
                </div>
            </div>
        @endif

        @include('content.event.recently_seen')

    </section>
@endsection


@section('footer')
    <script src="/js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="/js/jquery.fancybox.min.js" type="text/javascript"></script>
    <script src="/js/masonry.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function() {
            var container = document.querySelector('#masonry-grid');
            var msnry = new Masonry( container, {
                columnWidth: $(".grid-item").width(),
                itemSelector: '.grid-item',
                gutter: $(window).width() > 768 ? 30 : 20
            });
            container.classList.add('initiated')
        })
    </script>
@endsection
