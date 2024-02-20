@foreach($events as $d)
    <?php $big = $loop->index == 0 || $loop->index == 6; ?>
    <div class="@if($big) col-lg-8 @else col-lg-4 @endif col-mb">
        @include('teasers.teaser__event', compact('big'))
    </div>
@endforeach
