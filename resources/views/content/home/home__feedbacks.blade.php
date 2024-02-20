<section class="section__homefeedbacks">
    <div class="container mob-container mt-4">
        <div class="row align-items-center">
            <div class="col-md col order-md-0 order-0">
                <h2>Рецензии</h2>
            </div>
            <div class="col-md col-auto text-md-right order-md-1 order-1 mt-0">
                <div class="swiper-navigation">
                    <div class="swiper-button-prev swiper-feedbacks-prev">
                        <img src="/images/left.svg" alt="<" title="<"/>
                    </div>
                    <div class="swiper-button-next swiper-feedbacks-next">
                        <img src="/images/right.svg" alt=">" title=">"/>
                    </div>
                </div>
            </div>
            <div class="col-md-12 col-12 order-md-2 order-2">
                <div class="swiper-container feedbacks-swiper">
                    <div class="swiper-wrapper">
                        @foreach($feedbacks as $d)
                            <div class="swiper-slide">
                                @include('teasers.teaser__feedback')
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
