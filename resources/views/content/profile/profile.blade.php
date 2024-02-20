@extends('layouts.app')

@section('content')
    <section class="profile page">
        {{ Breadcrumbs::render('profile') }}
        <div class="container">
            @include('content.profile.profile-submenu', ['active' => '/profile'])
            <div class="narrow-content">
                <h2>Мои данные</h2>
                <input type="hidden" value="{{ json_encode(Auth::user()) }}" id="user-json"/>
                <div id="vue-profile" v-cloak>
                    <template v-if="user">
                        <div class="row mb-5">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="name" v-model="user.name" placeholder="Имя"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="email" class="form-control" name="email" v-model="user.email" placeholder="Email"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="phone" v-model="user.phone" placeholder="Телефон"/>
                                </div>
                            </div>
                        </div>
                        <h2>Сменить пароль</h2>
                        <div class="row mb-md-5">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="password" class="form-control" name="password" autocomplete="off" v-model="user.password" placeholder="Новый пароль"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="password" class="form-control" name="password_confirmation" v-model="user.password_confirmation" placeholder="Подтвердите пароль"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <button @click="submit" class="w-100 btn btn-themed mt-3" :disabled="loading">Сохранить</button>
                            </div>
                        </div>
                    </template>
                </div>
            </div>
        </div>
        <div class="bottom-space"></div>
    </section>
@endsection
