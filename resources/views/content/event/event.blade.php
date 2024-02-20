@extends('layouts.app', ['dark' => true])

@section('head')
    <link rel="stylesheet" href="/css/jquery.fancybox.min.css">
    <link rel="stylesheet" href="/css/swiper-bundle.min.css">
@endsection

@section('content')
    <section id="event-page" class="event">
        <div class="event__intro" data-parallax="scroll" data-speed="0.4" data-image-src="{{ $event->imagePrimarySrc('main') }}">
            <div class="shadow">
                <div class="shadow__content">
                    <div class="container mob-container">
                        <div class="row no-gutters">
                            <div class="col-md-12 col-auto order-md-1 order-2">
                                <div class="shadow__venue">
                                    @foreach($venues as $venue)
                                        <a href="{{ $venue->link }}">{{ $venue->title }}</a>@if(!$loop->last), @endif
                                    @endforeach
                                </div>
                            </div>
                            @if($event->category)
                                <div class="col-md-12 col-auto order-md-2 order-1">
                                    <div class="shadow__category">
                                        {{ $event->category->title }}
                                    </div>
                                </div>
                            @endif
                        </div>
                        <h1>{{ $event->title }}</h1>
                        <div>
                            <a href="#schedule" class="anchor-scroll btn btn-themed text-dark">Выбрать событие</a>
                        </div>
                    </div>
                </div>
            </div>
            {{--            <img src="{{ $event->imagePrimarySrc('main') }}" class="w-100" alt="{{ $event->title }}"/>--}}
        </div>

        <div class="event__description">
            <div class="container mob-container">
                <h2>О событии</h2>
                <div class="row">
                    <div class="col-md">
                        <div class="pr-md-5">
                            <article>{!! $event->description !!}</article>
                        </div>
                    </div>
                    <div class="col-md-auto">
                        @include('parts.share')
                    </div>
                </div>
            </div>
        </div>

        @if(count($media) > 1)
            <div class="event__gallery">
                <div class="container mob-container">
                    <div id="masonry-grid" >
                        @foreach($media as $m)
                            <a href="{{ $m->getUrl('main') }}" data-fancybox="gallery">
                                <img src="{{ $m->getUrl('main') }}" class="grid-item img" alt="{{ $event->title }}"/>
                            </a>
                        @endforeach
                    </div>
                </div>
            </div>
        @endif

        <div class="event__characteristics">
            <div class="container mob-container">
                <div class="row">
                    <div class="col-md-3 col-6"><span class="text-muted">Театр-постановщик</span></div>
                    <div class="col-md-9 col-6 mb-3">
                        @foreach($venues as $v)
                            <a href="{{ $v->link }}">{{ $v->title }}</a>@if(!$loop->last), @endif
                        @endforeach
                    </div>
                    @if($event->duration)
                        <div class="col-md-3 col-6"><span class="text-muted">Время</span></div>
                        <div class="col-md-9 col-6 mb-3">{{ $event->duration.' мин' }}</div>
                    @endif
                    @if($cast && count($cast))
                        <div class="col-md-3 col-6"><span class="text-muted">Актеры</span></div>
                        <div class="col-md-9 col-6 mb-3">
                            @foreach($cast as $v)
                                <a href="{{ $v->link }}">{{ $v->name }}</a>@if(!$loop->last), @endif
                            @endforeach
                        </div>
                    @endif
                </div>
            </div>
        </div>

        @if($timetables && count($timetables) > 0)
            <div class="event__schedule" id="schedule">
                <div class="container mob-container">
                    <div class="narrow-content">
                        <h2>Список событий</h2>
                        @foreach($timetables as $d)
                            @include('teasers.teaser__timetable')
                        @endforeach
                    </div>
                </div>
            </div>
        @endif

        @if($feedbacks && count($feedbacks) > 0)
            @include('content.home.home__feedbacks')
        @endif

        @include('content.event.recently_seen')

    </section>

@endsection

@section('footer')
    <script src="/js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="/js/jquery.fancybox.min.js" type="text/javascript"></script>
    <script src="/js/masonry.min.js" type="text/javascript"></script>
    <script src="/js/swiper-bundle.min.js"></script>
    <script src="/js/parallax.min.js"></script>
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

        $(document).ready(function(){
            $("a.anchor-scroll").on('click', function(event) {
                if (this.hash !== "") {
                    event.preventDefault();
                    var hash = this.hash;
                    $('html, body').animate({
                        scrollTop: $(hash).offset().top
                    }, 700, function(){
                        window.location.hash = hash;
                    });
                } // End if
            });
        });

    </script>

@endsection
