<div class="venue page-teaser">
    <div class="row align-items-center">
        <div class="col-md">
            <div class="venue__title">
                <a href="{{ $d->link }}">{{ $d->title }}</a>
            </div>
            @if($d->address)
                <div class="venue__address">
                    {{ $d->address }}
                </div>
            @endif
        </div>
        <div class="col-md-auto">
            <div class="venue__imagewrapper">
                <a class="venue__image" href="{{ $d->link }}">
                    <img src="{{ $d->imagePrimarySrc('thumb') }}" alt="{{ $d->title }}" title="{{ $d->title }}"/>
                </a>
            </div>
        </div>
    </div>
</div>
