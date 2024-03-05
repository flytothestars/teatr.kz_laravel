<template>
    <div class="info">
        <div class="row">
            <div class="col">
                <div class="event__image">
                    <img src="../../../../../img/image 15.png" />
                </div>
            </div>
            <div class="col-sm-9">
                <div class="col">
                    <div class="event__name">
                        <p class="h4 font-weight-bold">Золотой квадрат</p>
                    </div>
                    <div class="event__time mt-5 row">
                        <img
                            class="img-info mx-3 "
                            src="../../../../../img/Calendar - Dates.png"
                            alt=""
                        />
                        <p class="h5 font-weight-light">
                            Дата события: 25 мар. -
                            <span class="font-weight-bold">20:00</span>
                        </p>
                    </div>
                    <div class="event__place row">
                        <img
                            class="img-info mx-3"
                            src="../../../../../img/Pin.png"
                            alt=""
                        />
                        <p class="h5 font-weight-light">
                            Место проведения: <a class="link-geo" href="#">пр. Абая, 43</a>
                        </p>
                    </div>
                    <div class="event__price row">
                        <img
                            class="img-info pl-1 mx-3 img-last"
                            src="../../../../../img/₸.png"
                            alt=""
                        />
                        <!-- <span class="h4 font-weight-light mx-3">₸</span> -->
                        <p class="h5 font-weight-light">
                            Цены на билеты: 8 000 ₸ - 28 000 ₸
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { mapState } from "vuex";

export default {
    computed: {
        ...mapState(["step", "cart", "order", "timetable"])
    },
    data() {
        return {
            menu: [
                // { title: 'Расписание', mob_title: "Расписание", note: 'Выберите дату мероприятия' },
                { title: "Схема зала", mob_title: "Зал", note: "Выбор сектор" },
                {
                    title: "Схема сектора",
                    mob_title: "Сектор",
                    note: "Выбор места"
                },
                { title: "Оформление", mob_title: "Оформление", note: "Оплата" }
            ]
        };
    },
    methods: {
        stepClicked(step) {
            if (this.step == 3) {
                return;
            }
            // if(step == 1) {
            //     this.$router.push('/')
            // }
            if (
                step == 1 &&
                this.timetable &&
                this.timetable.type == "pricegroups"
            ) {
                return;
            }
            if (step == 1 && this.step == 2) {
                this.$store.commit("setStep", 1);
            }
            if (step == 3 && this.cart.length > 0) {
                this.$store.dispatch("generateOrder").then(res => {
                    this.$router.push("/order/" + res.id + "/" + res.hash);
                });
            }
        }
    }
};
</script>

<style scoped lang="scss">
.event__image {
    margin: 0 20px 0 30px;
    border-radius: 8px;
    img {
        width: auto;
        height: 181px;
        @media (max-width: 575px) {
            margin: 20px 0;
        }
    }
    @media (max-width: 575px) {
        margin: 0 auto;
        display: flex;
        justify-content: center;
    }
}
.event__name{
    @media (max-width: 575px) {
        p{
            text-align: center;
        }
    }
}
.link-geo{
    color: #3CA1FF;
}
.info {
    .img-info {
        width: 24px;
        height: 24px;
    }
    .img-last {
        width: 20px !important;
    }
    @media (max-width: 575px) {
        background: #F6F7F8;
        border-radius: 8px;
    }
}
</style>
