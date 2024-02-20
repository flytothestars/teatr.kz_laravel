<div class="feedback teaser h-100">
    <div class="feedback__title">{{ $d->title }}</div>
    <div class="feedback__body">{!! $d->description !!}</div>
    <div class="row align-items-center">
        <div class="col-md">
            <img src="{{ $d->imagePrimarySrc('thumb') }}" class="d-inline-block align-middle feedback__img" alt="{{ $d->title }}" title="{{ $d->name }}"/>
            <div class="d-inline-block align-middle">
                <div class="feedback__username">{{ $d->name }}</div>
                <div class="feedback__date d-md-none d-block">{{ dateFormat($d->date, false, true) }}</div>
            </div>
        </div>
        <div class="col-md-auto">
            <div class="feedback__date d-md-block d-none">{{ dateFormat($d->date, false, true) }}</div>
        </div>
    </div>
</div>
