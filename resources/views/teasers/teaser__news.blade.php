<div class="news teaser h-100">
    <a class="news__title" href="{{ $d->link }}">
        {{ $d->title }}
    </a>
    <div class="news__date">
        {{ dateFormat($d->date, false, true) }}
    </div>
</div>
