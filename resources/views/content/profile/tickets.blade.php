@extends('layouts.app')

@section('content')
    <section class="profile page">
        {{ Breadcrumbs::render('profiletickets') }}
        <div class="container">
            @include('content.profile.profile-submenu', ['active' => '/profile/tickets'])
            <h2>Мои билеты</h2>
            @foreach($orders as $order)
                <div class="ticket teaser mb-3 @if($order->paid) paid @endif">
                    <div class="row align-items-center">
                        <div class="col-md-3">
                            <div class="pr-md-0 pr-5">
                            Заказ # {{ $order->id }}
                            </div>
                        </div>
                        <div class="col-md-4">
                            {{ $order->timetable->event->title }}<br>
                            <span class="text-muted">{{ $order->timetable->formatted_date }}</span>
                        </div>
                        <div class="col-md-2">
                            <div class="text-muted">
                                Билетов: {{ $order->order_items_count }}
{{--                                <a href="{{ $order->tickets_link }}" target="_blank">Билетов: {{ $order->order_items_count }}</a>--}}
                            </div>
                        </div>
                        <div class="col-md-2">
                            @if($order->paid)
                                <span class="text-success">Оплачен</span>
                            @else
                                <span class="text-warning">Не оплачен</span>
                            @endif
                        </div>
                        <div class="col-md-1 d-md-block d-none">
                            @if($order->paid)
                                <a href="{{ $order->tickets_link }}" target="_blank">
                                    <img class="tickets-svg" src="/images/tickets.svg" alt="билеты"/>
                                </a>
                            @endif
                        </div>
                        @if($order->paid)
                            <a class="d-md-none d-block ticket__link" href="{{ $order->tickets_link }}" target="_blank">
                                <img class="tickets-svg" src="/images/tickets.svg" alt="билеты"/>
                            </a>
                        @endif
                    </div>
                </div>
            @endforeach
            {!! $orders->links('parts.paginator') !!}
        </div>
        <div class="bottom-space"></div>
    </section>
@endsection
