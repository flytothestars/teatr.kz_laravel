@extends('layouts.app')

@section('content')
    {{ Breadcrumbs::render('news') }}
    <div class="container">
        <h1 id="page-title">Новости</h1>
        <div class="row">
            @foreach($news as $d)
                <div class="col-lg-4 col-mb">
                    @include('teasers.teaser__news')
                </div>
            @endforeach
        </div>
        {!! $news->links() !!}
        <div class="bottom-space"></div>
    </div>
@endsection
