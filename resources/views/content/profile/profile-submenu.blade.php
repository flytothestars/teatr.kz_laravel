@php
    $menu = [
        ['url' => '/profile', 'title' => 'Профиль'],
        ['url' => '/profile/tickets', 'title' => 'Мои билеты'],
    ];
@endphp

<h1 id="page-title">Мой аккаунт</h1>
<div class="profile-submenu">
    @foreach($menu as $m)
        <a href="{{ $m['url'] }}" @if($active == $m['url']) class="active" @endif>{{ $m['title'] }}</a>
    @endforeach
</div>
