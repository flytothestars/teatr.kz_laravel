<?php
$menu = \App\Models\General\MenuItem::getMenu();
$networks = ['instagram', 'facebook', 'whatsapp', 'telegram'];
?>

<div class="mobile-menu">
    <a class="mob-menu-toggler">
        <img src="/images/close.svg" alt="закрыть"/>
    </a>
    <div class="content">
        <div>
            <a href="/">
                <img src="/images/logo.svg" alt="лого"/>
            </a>
        </div>
        <div class="hmenu">
            @foreach($menu as $m)
                @if($m->header)
                    @if(in_array($m->url,['/'.Request::path(), Request::path()]))
                        <span class="link active" >{{ $m->title }}</span>
                    @else
                        <a class="link" href="{{ $m->url }}">{{ $m->title }}</a>
                    @endif
                @endif
            @endforeach
        </div>
        <div class="mmenu">
        @auth
            <form action="/logout" method="post">
                @csrf
                <button class="dropdown-item profile-item px-0">Выйти</button>
            </form>
        @endauth
        @guest
            <a class="d-block" data-toggle="modal" data-target="#loginModal">Войти</a>
        @endguest
        </div>
        <div class="fmenu">
            @foreach($menu as $m)
                @if($m->footer1 || $m->footer2 || $m->footer3)
                    <a class="link @if($m->url == Request::path()) active @endif" href="{{ $m->url }}">{{ $m->title }}</a>
                @endif
            @endforeach
        </div>
        <div class="contacts">
            <div><a class="phone" href="tel:{{ getNumbers($settings['phone']->body) }}">{{ $settings['phone']->body }}</a></div>
            <div class="note">
                <div>С радостью ответим на все вопросы</div>
                <div>{{ $settings['schedule']->body ?? '-' }}</div>
                <div><a href="mailto:{{ $settings['email']->body }}">{{ $settings['email']->body }}</a></div>
            </div>
        </div>
        <div class="social">
            @foreach($networks as $n)
                <a class="footer__social @if($loop->first) ml-0 @endif" href="{{ $settings[$n]->body ?? '' }}" rel="nofollow">
                    <img src="/images/{{ $n }}.svg" alt="{{ $n }}" title="{{ $n }}"/>
                </a>
            @endforeach
        </div>
    </div>
</div>
