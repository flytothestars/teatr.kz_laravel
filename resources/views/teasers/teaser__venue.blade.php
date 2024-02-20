<div class="venue teaser">
    <div class="venue__imagewrapper">
        <a class="venue__image" href="{{ $d->link }}">
            <img src="{{ $d->imagePrimarySrc('thumb') }}" alt="{{ $d->title }}" title="{{ $d->title }}"/>
        </a>
    </div>
    <div class="venue__title">
        <a href="{{ $d->link }}">{{ $d->title }}</a>
    </div>
</div>
