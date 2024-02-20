<section class="section__homesubscribe">
    <div class="container mob-container">
        <div class="row align-items-center">
            <div class="col-md-6 col-12">
                Подпишитесь на акции и анонсы
                <img src="/images/heart.svg" alt="Подпишитесь" title="Подпишитесь"/>
            </div>
            <div class="col-md-6 col-12">
                <div id="vue-subscribe">
                    <div class="row align-items-center no-gutters">
                        <div class="col-md col-12 mt-md-0 mt-3">
                            <input placeholder="Ваш email" class="form-control" v-model="email"/>
                        </div>
                        <div class="col-md-auto col-12">
                            <button class="btn-themed ml-md-2 ml-0" @click="submit">ПОДПИСАТЬСЯ</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
