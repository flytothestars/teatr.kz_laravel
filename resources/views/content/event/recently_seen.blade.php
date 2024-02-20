@php
    $recently_seen = \App\Models\Specific\Event::recentlySeen();
@endphp

@if($recently_seen && count($recently_seen) > 0)
    <section class="recently-seen">
        <div>
            <div class="container mob-container">
                <h2>Вы недавно смотрели</h2>
                <div class="row">
                    @foreach($recently_seen as $d)
                        <div class="col-lg-4 col-mb">
                            @include('teasers.teaser__event')
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </section>
@endif
