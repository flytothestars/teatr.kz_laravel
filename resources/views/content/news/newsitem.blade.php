@extends('layouts.app')

@section('content')
    <section class="news-page page">
        {{ Breadcrumbs::render('newsitem', $newsitem) }}
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="news-page__leftmenu">
                        <h2 class="mb-4">Последние новости</h2>
                        <div>
                            @foreach($latest as $d)
                                <div class="@if(!$loop->last) border-bottom mb-3 @endif pb-3">
                                    @include('teasers.teaser__news')
                                </div>
                            @endforeach
                        </div>
                        <div class="bottom-space"></div>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="pl-md-5">
                        <h1 id="page-title">{{ $newsitem->title }}</h1>
                        <article>
                            {!! $newsitem->description !!}
                        </article>
                        <div class="bottom-space"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection
