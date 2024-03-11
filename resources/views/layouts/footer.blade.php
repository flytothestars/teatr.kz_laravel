<?php
$fmenu = \App\Models\General\MenuItem::getMenu();
$networks = ['instagram', 'facebook', 'whatsapp', 'telegram'];
?>

<footer class="footer__top">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8 col-12 text-md-left text-center">
                <a @if(Request::path() != '/') href="/" @endif>
                    <img src="/images/logo_w.svg" alt="Лого" title="Лого"/>
                </a>
            </div>
{{--            <div class="col-md-4 col-12 text-md-left text-center mt-md-0 mt-4">--}}
{{--                @foreach($networks as $n)--}}
{{--                    <a class="footer__social @if($loop->first) ml-0 @endif" href="{{ $settings[$n]->body ?? '' }}" rel="nofollow">--}}
{{--                        <img src="/images/{{ $n }}.svg" alt="{{ $n }}" title="{{ $n }}"/>--}}
{{--                    </a>--}}
{{--                @endforeach--}}
{{--            </div>--}}
        </div>
        <div class="row mt-5">
            <div class="col-md-8 d-md-block d-none">
                <div class="row">
                    <div class="col-md-4">
                        @foreach($fmenu as $m)
                            @if($m->footer1)
                                <a class="footer__menuitem @if($m->url == Request::path()) active @endif" href="{{ $m->url }}">{{ $m->title }}</a>
                            @endif
                        @endforeach
                    </div>
                    <div class="col-md-4">
                        @foreach($fmenu as $m)
                            @if($m->footer2)
                                <a class="footer__menuitem @if($m->url == Request::path()) active @endif" href="{{ $m->url }}">{{ $m->title }}</a>
                            @endif
                        @endforeach
                    </div>
                    <div class="col-md-4">
                        @foreach($fmenu as $m)
                            @if($m->footer3)
                                <a class="footer__menuitem @if($m->url == Request::path()) active @endif" href="{{ $m->url }}">{{ $m->title }}</a>
                            @endif
                        @endforeach
                    </div>
                </div>
            </div>
            <div class="col-md-4 footer__contacts">
                <div><a class="footer__phone" href="tel:{{ getNumbers($settings['phone']->body) }}">{{ $settings['phone']->body }}</a></div>
                <div>С радостью ответим на все вопросы</div>
                <div>{{ $settings['schedule']->body ?? '' }}</div>
                <div><a href="mailto:{{ $settings['email']->body }}">{{ $settings['email']->body }}</a></div>
            </div>
        </div>
    </div>
</footer>
<footer class="footer__bottom">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md col-12 text-md-left text-center">
                © {{ date('Y') }}, ТОО «Teatr.kz». Все права защищены.
            </div>
            <div class="col-md-auto col-12 mt-md-0 mt-2 text-md-left text-center">
                <img class="d-inline-block align-middle footer__visa" src="/images/visa.svg" alt="visa" title="visa"/>
                <img class="d-inline-block align-middle ml-2 footer__mastercard" src="/images/mastercard.svg" alt="mastercard" title="mastercard"/>
                
            </div>
        </div>
    </div>
</footer>
