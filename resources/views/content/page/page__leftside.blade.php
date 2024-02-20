@php
    $pages = \App\Models\General\Page::active()
->select('id','title','page_group','slug')
->get()
->groupBy('page_group');
$order = ['about','purchase','partnership','legal'];
@endphp

<div class="static-page__leftmenu">
    @foreach($order as $o)
        @if(isset($pages[$o]))
            <div class="static-page__menublock">
                <h2>{{ __($o) }}</h2>
                @foreach($pages[$o] as $item)
                    <a href="{{ $item->link }}" class="d-block @if(Request::path() == $item->slug) active @endif">{{ $item->title }}</a>
                @endforeach
            </div>
        @endif
    @endforeach
</div>
