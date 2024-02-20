@extends('layouts.app')

@section('content')
    {{ Breadcrumbs::render('passwordreset') }}
    <div class="container">

        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <h1 id="page-title">{{ __('Reset Password') }}</h1>
                <div class="">

                    <form method="POST" action="{{ route('password.update') }}">
                        @csrf

                        <input type="hidden" name="token" value="{{ $token }}">

                        <div class="form-group">
                            <input id="email" type="email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ $email ?? old('email') }}" required autocomplete="email" autofocus>
                            @error('email')
                            <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                            @enderror
                        </div>

                        <div class="form-group">
                            <input id="password" type="password" class="form-control @error('password') is-invalid @enderror" name="password" placeholder="Пароль" required autocomplete="new-password">
                            @error('password')
                            <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                            @enderror
                        </div>

                        <div class="form-group">
                            <input id="password-confirm" type="password" class="form-control" name="password_confirmation" placeholder="Подтверждение пароля" required autocomplete="new-password">
                        </div>

                        <div class="form-group mb-0">
                            <button type="submit" class="btn btn-themed w-100">
                                {{ __('Reset Password') }}
                            </button>
                        </div>
                    </form>
                    <div class="bottom-space"></div>
                </div>
            </div>
        </div>
    </div>
@endsection
