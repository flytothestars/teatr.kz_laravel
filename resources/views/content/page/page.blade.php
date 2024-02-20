@extends('layouts.app')

@section('content')
    <section class="static-page page">
        {{ Breadcrumbs::render('page', $page) }}
        <div class="container mob-container">
            <div class="row">
                <div class="col-md-3 order-md-1 order-2">
                    @include('content.page.page__leftside')
                    <div class="bottom-space d-md-block d-none"></div>
                </div>
                <div class="col-md-9 order-md-2 order-1">
                    <div class="pl-md-5">
                        <h1 id="page-title">{{ $page->title }}</h1>
                        <article>
                            {!! $page->body !!}
                        </article>
                    </div>
                    <div class="bottom-space"></div>
                </div>
            </div>
        </div>
    </section>
@endsection
