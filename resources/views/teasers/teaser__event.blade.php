<div class="event teaser border h-100 @if(isset($big) && $big) big @endif">
    <a href="{{ $d->link }}">
        <img class="event__img" src="{{ $d->imagePrimarySrc('teaser') }}" alt="{{ $d->title }}" title="{{ $d->title }}"/>
    </a>
    @if($d->category)
        <div class="event__category">
            {{ $d->category->title }}
        </div>
    @endif
    <div class="event__content">
        <div class="event__topinfo">
            <div class="event__datetime">
                <a href="{{ $d->link }}">
                    {{ $d->timetables[0]->formatted_date }}
                </a>
            </div>
            <h3 class="event__title">
                <a href="{{ $d->link }}">{{ $d->title }}</a>
            </h3>
            @if($d->short)
                <p class="event__short">{{ $d->short }}</p>
            @endif
        </div>
        <div class="event__venue">
            <a href="{{ $d->timetables[0]->venue->link }}">
                {{ $d->timetables[0]->venue->title }}
            </a>
        </div>
    </div>
</div>
