@extends('layouts.app')

@section('content')
    {{ Breadcrumbs::render('partners') }}
    <div class="container">
        <h1 id="page-title">Партнеры</h1>
        <div class="narrow-content">
            @foreach($partners as $partner)
                <div class="partner teaser">
                    <div class="row">
                        <div class="col-md-auto">
                            <img src="{{ $partner->imagePrimarySrc('thumb') }}" alt="{{ $partner->title }}"/>
                        </div>
                        <div class="col-md">
                            <h2>{{ $partner->title }}</h2>
                            <article>
                                {!! $partner->description !!}
                            </article>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    </div>
@endsection
