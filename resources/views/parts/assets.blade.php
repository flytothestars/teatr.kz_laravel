<link rel="stylesheet" href="/css/select2.min.css">
<link rel="stylesheet" href="{{ mix('css/app.css') }}">

<script type="text/javascript" src="/js/lang.js"></script>
@if(isset($widget) && $widget)
    <script src="{{ mix('js/widget.js') }}" defer></script>
@else
    <script src="{{ mix('js/site.js') }}" defer></script>
@endif
<script type="text/javascript" defer src="/js/select2.min.js"></script>
