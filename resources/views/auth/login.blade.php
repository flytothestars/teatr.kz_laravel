@extends('layouts.app')

@section('content')
    <div class="container">
        <div class="d-flex justify-content-center align-items-center">

            <div>
{{--                @include('parts.logo')--}}

{{--                <h1>{{ __('Login') }}</h1>--}}

                <form method="POST" class="mt-5 pb-5" action="{{ route('login') }}">
                    @csrf

                    <div class="form-group">
{{--                        <label for="email">{{ __('E-Mail') }}</label>--}}

                        <input id="email" type="email" placeholder="Email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required autocomplete="email" autofocus>

                        @error('email')
                        <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                        @enderror
                    </div>

                    <div class="form-group">
{{--                        <label for="password">{{ __('Password') }}</label>--}}

                        <input id="password" type="password" placeholder="Пароль" class="form-control @error('password') is-invalid @enderror" name="password" required autocomplete="current-password">

                        @error('password')
                        <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                        @enderror
                    </div>

                    {{--                    <div class="form-group row">--}}
                    {{--                        <div class="col-md-6 offset-md-4">--}}
                    {{--                            <div class="form-check">--}}
                    {{--                                <input class="form-check-input" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>--}}

                    {{--                                <label class="form-check-label" for="remember">--}}
                    {{--                                    {{ __('Remember Me') }}--}}
                    {{--                                </label>--}}
                    {{--                            </div>--}}
                    {{--                        </div>--}}
                    {{--                    </div>--}}

                    <div class="form-group mb-0">
                        <button type="submit" class="btn btn-themed w-100">
                            Войти
                        </button>


{{--                        @if (Route::has('password.request'))--}}
{{--                            <div>--}}
{{--                                <a class="btn btn-link" href="{{ route('password.request') }}">--}}
{{--                                    {{ __('Forgot Your Password?') }}--}}
{{--                                </a>--}}
{{--                            </div>--}}
{{--                        @endif--}}
                    </div>
                </form>
            </div>


        </div>
    </div>
@endsection
