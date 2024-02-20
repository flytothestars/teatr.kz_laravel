@extends('layouts.app')

@section('head')
    <link rel="stylesheet" href="/css/jquery.fancybox.min.css">
    <link rel="stylesheet" href="/css/swiper-bundle.min.css">
@endsection

@section('body-class', 'venue')

@section('content')
    <section class="venue page">
        {{ Breadcrumbs::render('venueitem', $venueitem) }}
        <div class="venue__intro">
            <div class="container mob-container">
                <div class="row">
                    <div class="col-md-auto">
                        <div class="venue__image">
                            <img src="{{ $venueitem->imagePrimarySrc('thumb') }}" alt="{{ $venueitem->title }}" title="{{ $venueitem->title }}"/>
                        </div>
                    </div>
                    <div class="col-md">
                        <h1 id="page-title">{{ $venueitem->title }}</h1>
                        <div class="row">
                            <div class="col">
                                <div class="pr-md-5">
                                    <article>{!! $venueitem->description !!}</article>
                                </div>
                            </div>
                            <div class="col-auto">
                                @include('parts.share')
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        @if(count($media) > 1)
            <div class="venue__gallery">
                <div class="container mob-container">
                    <div id="masonry-grid" >
                        @foreach($media as $m)
                            @if(!$loop->first)
                                <a href="{{ $m->getUrl('main') }}" data-fancybox="gallery">
                                    <img src="{{ $m->getUrl('main') }}" class="grid-item img" alt="{{ $venueitem->title }}"/>
                                </a>
                            @endif
                        @endforeach
                    </div>
                </div>
            </div>
        @endif

        @if($venueitem->address)
            <div class="venue__address">
                <div class="container mob-container">
                    <h2>Адрес</h2>
                    <p class="venue__addressline">{{ $venueitem->address }}</p>
                    @if($venueitem->x_coord && $venueitem->y_coord)
                        <div id="yamap" class="venue__map"></div>
                    @endif
                </div>
            </div>
        @endif

        @if($events && count($events) > 0)
            <div class="venue__events">
                <div class="container mob-container">
                    <h2>Репертуар</h2>
                    <div class="row">
                        @foreach($events as $d)
                            <div class="col-lg-4 col-mb">
                                @include('teasers.teaser__event')
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>
        @endif

        @include('content.home.home__venues', ['title' => 'Другие театры'])

        @include('content.event.recently_seen')

    </section>
@endsection

@section('footer')
    <script src="/js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="/js/jquery.fancybox.min.js" type="text/javascript"></script>
    <script src="/js/masonry.min.js" type="text/javascript"></script>
    <script src="/js/swiper-bundle.min.js"></script>
    <script>
        $.getScript( "https://api-maps.yandex.ru/2.1/?apikey=897e0489-4658-4915-b7b2-eaa365324138&lang=ru_RU" ).done(function( script, textStatus ) {
            $(function() {
                ymaps.ready(init);
                var myMap, myPlacemark, x, y;
                x = {{ $venueitem->x_coord }};
                y = {{ $venueitem->y_coord }};
                function init() {
                    myMap = new ymaps.Map("yamap", {
                        center: [x, y],
                        zoom: 15,
                        controls: ['zoomControl']
                    });
                    myPlacemark = new ymaps.Placemark([x, y], {
                        hintContent: 'Saubol',
                    });
                    myMap.geoObjects.add(myPlacemark);
                    myMap.behaviors.disable('scrollZoom');
                }
            })
        });

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
