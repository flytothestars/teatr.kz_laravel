@guest
    <div class="modal fade" id="loginModal" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-body" id="vue-login">
                    <div class="text-center">
                        <div class="">
                            <img src="/images/logo.svg" alt="лого"/>
                        </div>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h2 class="mt-5 mb-5">Вход</h2>
                        <div class="login-popup__form text-center mx-auto">
                            <div class="form-group">
                                <input type="text" v-model="form.email" class="form-control" placeholder="Email"/>
                            </div>
                            <div class="form-group"  v-if="mode === 'login' || mode === 'register'">
                                <input type="password" @keyup.enter="submit" v-model="form.password" class="form-control" placeholder="Пароль"/>
                            </div>
                            <div class="text-left" v-if="mode === 'login'">
                                <a class="text-muted pointer" @click="mode = 'reset'">Забыли пароль?</a>
                            </div>
                            <div class="form-group" v-if="mode === 'register'">
                                <input type="password" @keyup.enter="submit" v-model="form.password_confirmation" class="form-control" placeholder="Подтвердить пароль"/>
                            </div>
                            <div class="alert alert-danger" v-if="error">@{{ error }}</div>
                            <button @click="submit" class="w-100 btn btn-themed mt-4" :disabled="loading">
                                <span v-if="mode === 'reset'">Сбросить пароль</span>
                                <span v-if="mode === 'login'">Войти</span>
                                <span v-if="mode === 'register'">Зарегистрироваться</span>
                            </button>
                            <div class="mt-4 text-uppercase">
                                <a v-if="mode === 'login'" class="pointer" @click="mode = 'register'">Зарегистрироваться</a>
                                <a v-if="mode === 'register'" class="pointer" @click="mode = 'login'; form.password_confirmation = ''">Авторизоваться</a>
                                <a v-if="mode === 'reset'" class="pointer" @click="mode = 'login'; form.password_confirmation = ''">Авторизоваться</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endguest
