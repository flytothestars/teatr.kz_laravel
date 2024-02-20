@extends('layouts.app', ['min' => true])

@section('content')
    <div class="page-404 d-flex align-items-center position-relative">
        <div class="position-absolute w-100 logo-wrapper-404">
            <div class="container mob-container mt-4 text-md-left text-center">
                <img src="/images/logo_w.svg" alt="лого"/>
            </div>
        </div>
        <div class="container mob-container">
            <div class="row">
                <div class="col-md-6 order-md-1 order-2">
                    <p class="mb-md-5 mb-4">Упсс..<br>
                        Кажется такой страницы у нас<br>
                        еще не существует</p>
                    <a class="btn btn-themed text-black-50" href="/">Вернуться на главную</a>
                </div>
                <div class="col-md-6 order-md-2 order-1">
                    <img src="/images/404.svg" alt="404"/>
                </div>
            </div>

        </div>
    </div>
@endsection
