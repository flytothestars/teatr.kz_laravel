<div class="timetable teaser">
    <div class="row align-items-center mb-3">
        <div class="col">
            @if($d->event)
                <div class="timetable__title">{{ $d->event->title }}</div>
            @endif
            <div class="timetable__datetime">
                {{ $d->formatted_date }}
            </div>
        </div>
        <div class="col-auto">{{ $d->event->min_price }}</div>
    </div>
    <div class="row align-items-center">
        <div class="col-md order-md-1 order-2">
            <div class="timetable__venue">{{ $d->venue->title }}</div>
        </div>
        <div class="col-md-auto order-md-2 order-1">
            <a class="btn btn-dark" href="https://teatr.kz/new_widget#/{{ $d->event_id }}/{{ $d->id }}">Купить билет</a>
        </div>
    </div>
</div>
