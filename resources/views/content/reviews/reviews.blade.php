@extends('layouts.app')

@section('content')
    {{ Breadcrumbs::render('reviews') }}
    <div class="container">
        <h1 id="page-title">Рецензии</h1>
        <div class="row">
            @foreach($feedbacks as $d)
                <div class="col-md-6">
                    <div class="border h-100">
                    @include('teasers.teaser__feedback')
                    </div>
                </div>
            @endforeach
        </div>
        {!! $feedbacks->links() !!}
        <div class="bottom-space"></div>
    </div>
@endsection
