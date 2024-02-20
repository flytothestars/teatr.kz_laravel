@php
    $pay_methods = [
        'card' => 'картой',
        'organizer' => 'организатор',
        'paybox' => 'paybox'
    ];
    $timetable = isset($order) ? $order->timetable : null;
    $event = $timetable ? $timetable->event : null;
@endphp

<div class="row mt-3">
    <div class="col-6">
        <div class="">
            <h5>О заказе</h5>
            <table class="table table-striped">
                <tbody>
                <tr>
                    <td>Инициирован</td>
                    @if($order->pay_system == 'organizer')
                        <td><span class="badge badge-info">Организатором</span></td>
                    @else
                        <td><span class="badge badge-secondary">Пользователем</span></td>
                    @endif
                </tr>

                <tr>
                    <td>Событие</td>
                    <td>{{ $event ? $event->title : '-' }}</td>
                </tr>
                <tr>
                    <td>Сеанс</td>
                    <td>{{ $timetable ? dateFormat($timetable->datetime, true) : '-' }}</td>
                </tr>
                <tr>
                    <td>Сумма</td>
                    <td>{{ number_format($order->price,0,"."," ") }}</td>
                </tr>
                <tr>
                    <td>Метод оплаты</td>
                    <td>{{ $order->pay_system ? $pay_methods[$order->pay_system] : 'не выбран' }}</td>
                </tr>
{{--                <tr>--}}
{{--                    <td>Платформа</td>--}}
{{--                    <td>{{ $order->platform }}</td>--}}
{{--                </tr>--}}
                <tr>
                    <td>Создан</td>
                    <td>{{ dateFormat($order->created_at,true,true) }}</td>
                </tr>
                <tr>
                    <td>Статус</td>
                    <td>
                        @if($order->paid) <span class="badge badge-success">Оплачен</span> @else <span class="badge badge-secondary">Создан</span> @endif
                        @if($order->trashed()) <span class="badge badge-danger">Удален</span> @endif
                    </td>
                </tr>
                <tr>
                    <td>Билеты отправлены</td>
                    <td>
                        @if($order->sent) <span class="badge badge-success">Отправлены</span> @else <span class="badge badge-secondary">Нет</span> @endif
                    </td>
                </tr>
                @if($order->paid)
                    <tr>
                        <td>Ссылочный номер транзакции</td>
                        <td>{{ $order->pay_id }}</td>
                    </tr>
                @endif
{{--                @if($order->paid && $order->pay_system == 'card')--}}
{{--                    <tr>--}}
{{--                        <td>Внутренняя ссылка</td>--}}
{{--                        <td>{{ $order->int_ref }}</td>--}}
{{--                    </tr>--}}
{{--                    <tr>--}}
{{--                        <td>Код авторизации</td>--}}
{{--                        <td>{{ $order->auth_code }}</td>--}}
{{--                    </tr>--}}
{{--                @endif--}}
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-6">
        <h5>О клиенте</h5>
        <div>
            @if($order->email || $order->name || $order->phone)
                <div>
                    <div>{{ $order->email }}</div>
                    <div>{{ $order->name }}</div>
                    <div>{{ $order->phone }}</div>
                </div>
            @else
                <div>Клиент еще не ввел данные</div>
            @endif
        </div>
        <div class="mt-4">
            <h5>Билеты</h5>
            <table class="table table-striped">
                <tbody>
                @foreach($order->orderItems as $item)
                    <tr>
                        @if($item->section)
                            <td>Сектор: {{ $item->section->title }}</td>
                        @endif
                        @if($item->row)
                            <td>Ряд: {{ $item->row }}</td>
                        @endif
                        @if($item->seat)
                            <td>Место: {{ $item->seat }}</td>
                        @endif
                        @if(!$item->row && !$item->seat)
                            @if($item->pricegroup)
                                <td colspan="2">{{ $item->pricegroup->title }}</td>
                            @else
                                <td colspan="2">Входной</td>
                            @endif

                        @endif
                        <td>{{ number_format($item->price,0,"."," ") }} тг</td>
                    </tr>
                @endforeach
                </tbody>
            </table>
        </div>
        @if($order->paid && in_array($order->pay_system,['card','paybox']))
{{--            <form method="post" action="/admin/order/{{ $order->id }}/return" class="mt-5 text-right" onsubmit="return confirm('Вы уверены, что хотите вернуть деньги по этому заказу на карту клиенту?')">--}}
{{--                @csrf--}}
{{--                <button type="submit" class="btn btn-themed btn-danger text-white">Возврат денег на карту</button>--}}
{{--            </form>--}}
        @endif
    </div>
</div>
