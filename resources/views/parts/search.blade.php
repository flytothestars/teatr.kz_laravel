<div class="search-block">
    {{--    <a id="search-close">x</a>--}}
    <div class="container mob-container">
        <form method="get" action="/search">
            <div class="row">
                <div class="col-md-auto">
                    <input type="text" class="form-control" placeholder="поиск" name="q" value="{{ Request::get('q') }}"/>
                </div>
                <div class="col-md-auto mt-md-0 mt-2">
                    <button class="btn btn-themed">Поиск</button>
                </div>
            </div>
        </form>
    </div>

</div>
