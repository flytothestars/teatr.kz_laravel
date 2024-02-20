<section class="section__homenews">
    <div class="container mob-container mt-4">
        <div class="row">
            <div class="col">
                <h2>Новости</h2>
            </div>
            <div class="col-auto">
                <a class="gray-link" href="/news">Все новости</a>
            </div>
        </div>
        <div class="news-wrapper">
            <div class="row">
                @foreach($news as $d)
                    <div class="col-lg-4 col-mb">
                        @include('teasers.teaser__news')
                    </div>
                @endforeach
            </div>
        </div>
    </div>
</section>
