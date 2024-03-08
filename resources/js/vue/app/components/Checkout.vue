<template>
    <div>
        <!-- <div class="row mb-md-5 mb-4 mt-4 align-items-center">
            <div class="col">
                <h1 class="mb-0">Оформление заказа</h1>
            </div>
            <div class="col-auto" v-if="order">
                <div class="d-md-inline-block d-none">Время на оформление:</div>
                <div class="d-inline-block countdown ml-2">
                    <span v-if="checkouttime > 0">{{ minutes }}:{{ seconds }}</span>
                    <span v-if="checkouttime <= 0">истекло</span>
                </div>
            </div>
        </div> -->

        <div v-if="order">
            <!-- <div class="form-group">
                <label class="label-ch" for="email-ch">Email:</label>
                <div class="row align-items-center">
                    <div class="col-md-7 col-12">
                        <input type="email" id="email-ch" class="form-control" v-model="form.email"/>
                    </div>
                    <div class="col-md-5 col-12">
                        <div class="note-ch">На данный электронный asdas адрес будут отправлены билеты после оплаты.</div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="label-ch" for="phone-ch">Телефон:</label>
                <div class="row align-items-center">
                    <div class="col-md-7 col-12">
                        <input type="text" id="phone-ch" class="form-control" v-model="form.phone"/>
                    </div>
                    <div class="col-md-5 col-12">
                        <div class="note-ch">Мобильный телефон, по которому мы сможем с Вами связаться.</div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="label-ch" for="name-ch">Имя:</label>
                <div class="row align-items-center">
                    <div class="col-md-7 col-12">
                        <input type="text" id="name-ch" class="form-control" v-model="form.name"/>
                    </div>
                    <div class="col-md-5 col-12">
                        <div class="note-ch">Данное имя будет указано на билете.</div>
                    </div>
                </div>
            </div> -->

            <div class="row new-ticket my-4">
                <div class="col-md-3 text-center ticket ticket__left">
                    <p class="h2">20:00</p>
                    <p class="h5 font-weight-light">25 мар.</p>
                </div>
                <div class="col-md-9 ticket ticket__right">
                    <div class="h5 mt-3">Золотой квадрат</div>
                    <div class="row align-items-center">
                        <img class="ml-3" src="../../../../img/Pin.png" alt="" />
                        <p class="mb-0 ml-3 font-weight-light">Место проведения: <a class="mark-link" href="#">пр.Абая 43</a></p>
                    </div>
                    <div class="row my-2">
                        <span class="mark ml-3 font-weight-light">0+</span>
                        <span class="mark ml-2 font-weight-light">РУС</span>
                    </div>
                    <div class="row justify-content-between text-center">
                        <div class="row col-md-8 block-mark">
                            <div class="mark-big  font-weight-light">Партер</div>
                            <div class="mark-big ml-3 font-weight-light">7 ряд, 1 место</div>
                        </div>
                        <div class="col-md-4 text-center">
                            <p class="h2 mark-price ">15 000тг</p>
                        </div>
                    </div>
                </div>
            </div>
            <h4 class="h4">Выберите способ оплаты</h4>
            <div class="row mb-3">
                <div class="col-md-4 card-parent">
                    <div class="card">
                        <div class="card-body">
                            <img class="mb-5" src="../../../../img/image 17.png" alt="">
                            <p class="card-text">Оплатить через каспи</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 card-parent">
                    <div class="card">
                        <div class="card-body">
                            <img class="mb-5" src="../../../../img/image 18.png" alt="">
                            <p class="card-text">Рассрочка</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 card-parent">
                    <div class="card ">
                        <div class="card-body">
                            <img class="mb-5" src="../../../../img/image 19.png" alt="">
                            <p class="card-text">Карты Visa/MasterCard</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</template>

<script>
import { mapState } from "vuex";
import EventBus from "../../../event-bus";
import moment from "moment";

export default {
    name: "Checkout",
    computed: {
        ...mapState([
            "cart",
            "timetable",
            "order",
            "event",
            "user",
            "checkouttime",
            "userphone",
            "useremail",
        ]),
        minutes() {
            return String(Math.floor(this.checkouttime / 60)).padStart(2, "0");
        },
        seconds() {
            return String(this.checkouttime % 60).padStart(2, "0");
        }
    },
    created() {
        this.$store.commit("setStep", 3);
        if (!this.order) {
            this.loadOrder();
        }
        EventBus.$on("fillOrder", this.orderFill);
        this.populateFromUser();
        this.phone = this.userphone
        this.email = this.useremail
        this.launchTimer();
    },
    methods: {
        launchTimer() {
            if (this.order) {
                this.countdown();
                this.timer = setInterval(this.countdown, 1000);
            }
        },
        loadOrder() {
            window.loaderIcon();
            axios
                .get(
                    `/api/order/${this.$route.params.id}/${this.$route.params.hash}`
                )
                .then(res => {
                    let order = res.data.order;
                    this.$store.commit("setOrder", order);
                    this.$store.commit("setUser", res.data.user);
                    this.$store.commit("setTimetable", order.timetable);
                    order.order_items.forEach(item => {
                        let sign = "+";
                        let ticket = {
                            seat_id: item.seat_id,
                            section_id: item.section_id,
                            row: item.row,
                            seat: item.seat,
                            price: item.price,
                            section_name: item.section ? item.section.title : {}
                        };
                        this.$store.commit("updateCart", { sign, ticket });
                    });
                    this.form.name = order.name;
                    this.form.email = this.useremail;
                    this.form.phone = this.userphone;
                    if (!order.name) {
                        this.populateFromUser();
                    }
                    this.launchTimer();
                });
        },
        populateFromUser() {
            if (this.user) {
                this.form.name = this.user.name;
                this.form.email = this.useremail;
                this.form.phone = this.userphone;
            }
        },
        orderFill() {
            if (this.order.pay_url) {
                window.location = this.order.pay_url;
                return;
            }
            window.loaderIcon();
            axios
                .post(`/api/order/${this.order.id}/${this.order.hash}/fill`, {
                    ...this.form,
                    timetable_id: this.timetable.id
                })
                .then(res => {
                    let d = res.data;
                    if (d && d.success && d.redirect) {
                        window.location = d.redirect;
                        return;
                    }
                    if (d && d.error) {
                        window.noty(d.error, "error");
                        return;
                    }
                    if (d && d.success && this.form.pay_system == "card") {
                        this.launchCloudPay();
                        return;
                    }
                    window.noty("Что-то пошло не так", "error");
                });
        },
        cancelOrder() {
            window.loaderIcon();
            axios
                .delete(`/api/order/${this.order.id}/${this.order.hash}`)
                .then(res => {
                    this.$router.push("/");
                });
        },
        countdown() {
            if (!this.order) return;
            let now = moment(new Date());
            let end = moment(this.order.created_at);
            this.$store.commit(
                "setCheckoutTime",
                Math.round(
                    this.timeToCheckout -
                        moment.duration(now.diff(end)).asSeconds()
                )
            );
            if (this.checkouttime <= 0 && this.timer) {
                clearInterval(this.timer);
            }
        },
        launchCloudPay() {
            var widget = new cp.CloudPayments({ language: "kk" });
            let order = this.order;
            widget.charge(
                {
                    // options
                    publicId: "pk_3e80657de67d651fc26d5c23b4bc7", // id из личного кабинета
                    description:
                        "Оплата за " +
                        this.timetable.event.title.ru +
                        " (" +
                        this.timetable.formatted_date +
                        "), заказ " +
                        this.order.id, // назначение
                    amount: this.order.price, // сумма
                    currency: "KZT", // валюта
                    invoiceId: this.order.id, // номер заказа  (необязательно)
                    accountId: this.form.email, // идентификатор плательщика (необязательно)
                    skin: "mini", // дизайн виджета
                    data: {
                        hash: this.order.hash
                    }
                },
                function(options) {
                    // success
                    window.noty(
                        "Спасибо!",
                        "Ваша оплата прошла успешно - билеты будут отправлены Вам на указанный email."
                    );
                    axios
                        .get(`/admin/order/${this.order.id}/ticket/send`)
                        .then(res => {
                            console.log("success");
                        });
                    setTimeout(() => {
                        window.location = `${window.location.origin}/order/${order.id}/${order.hash}/pdf`;
                    }, 500);
                },
                function(reason, options) {
                    // fail
                    console.log(reason);
                    console.log(options);
                    window.noty("Оплата не прошла", "error");
                }
            );
        }
    },
    data() {
        return {
            form: {
                name: "",
                email: "",
                phone: "",
                pay_system: "card"
            },
            timeToCheckout: 30 * 60,
            timer: null
        };
    },
    metaInfo() {
        return {
            title: "Оформление заказа",
            meta: []
        };
    }
};
</script>

<style scoped lang="scss">
.new-ticket {
    .ticket {
        border: 1px solid #e7e8ed;
        border-radius: 16px;
        &__left {
            border-right: 1px dashed #e7e8ed;
            display: flex;
            flex-direction: column;
            flex-wrap: nowrap;
            justify-content: center;
            @media (max-width: 768px){
                font-size: 14px;
                border-right: 1px solid #e7e8ed;
                border-bottom: 1px dashed #e7e8ed;
            }
        }
        &__right {
            border-left: none;
            @media (max-width: 768px){
                border-left: 1px solid #e7e8ed;
                border-top: none;
            }
            div{
                img{
                    width: 24px;
                    height: 24px;
                }
            }
        }
    }
}

.mark{
    background: #fff;
    border: 1px solid #D1D3DF;
    border-radius: 8px;
}
.block-mark{
    margin:0 0 8px 0;
    @media (max-width: 768px){
        margin: 0!important;
        padding: 0!important;
    }

}
.mark-big{
    background: #CEE8FF;
    border-radius: 10px;
    border: 1px solid #CEE8FF;
    padding:5px 10px ;
    @media (max-width: 768px){
        width: 100%;
        margin: 0 10px 10px!important;
        padding: 10px!important;
    }
}
.mark-link{
    color: #3CA1FF;
    cursor: pointer;
}
.card{
    border-radius: 16px;
    &:first-child{
        padding-left: 0;
    }
    &:last-child{
        padding-right: 0;
    }
    .card-body{
        img{
            width: 40%;
            height: auto;
        }
    }
    &:hover{
        border: 1px solid #FFC737;
        box-shadow: 0px 18px 22.600000381469727px 0px #9194B740;

    }
}


.card-parent:first-child{
        padding-left: 0;

    }
.card-parent:last-child{
        padding-right: 0;

    }
    .card-parent{
        @media (max-width: 768px){
        padding: 0;
        margin-bottom: 10px;
    }
    }
</style>
