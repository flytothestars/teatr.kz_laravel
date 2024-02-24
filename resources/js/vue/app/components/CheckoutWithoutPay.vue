<template>
    <div>
        <div class="row mb-md-5 mb-4 mt-4 align-items-center">
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
        </div>

        <div v-if="order">

            <div class="form-group">
                <label class="label-ch" for="email-ch">Email:</label>
                <div class="row align-items-center">
                    <div class="col-md-7 col-12">
                        <input type="email" id="email-ch" class="form-control" v-model="form.email" />
                    </div>
                    <div class="col-md-5 col-12">
                        <div class="note-ch">На данный электронный адрес будут отправлены билеты после оплаты.</div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="label-ch" for="phone-ch">Телефон:</label>
                <div class="row align-items-center">
                    <div class="col-md-7 col-12">
                        <input type="text" id="phone-ch" class="form-control" v-model="form.phone" />
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
                        <input type="text" id="name-ch" class="form-control" v-model="form.name" />
                    </div>
                    <div class="col-md-5 col-12">
                        <div class="note-ch">Данное имя будет указано на билете.</div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>

<script>
import { mapState } from 'vuex'
import EventBus from '../../../event-bus'
import moment from 'moment'

export default {
    name: "Checkoutwithoutpay",
    computed: {
        ...mapState(['cart', 'timetable', 'order', 'event', 'user', 'checkouttime']),
        minutes() {
            return String(Math.floor(this.checkouttime / 60)).padStart(2, '0')
        },
        seconds() {
            return String(this.checkouttime % 60).padStart(2, '0')
        }
    },
    created() {
        this.$store.commit('setStep', 3)
        if (!this.order) {
            this.loadOrder()
        }
        EventBus.$on('fillOrder', this.orderFill)
        this.populateFromUser()
        this.launchTimer()
    },
    methods: {
        launchTimer() {
            if (this.order) {
                this.countdown()
                this.timer = setInterval(this.countdown, 1000)
            }
        },
        loadOrder() {
            window.loaderIcon()
            axios.get(`/api/order/${this.$route.params.id}/${this.$route.params.hash}`).then(res => {
                let order = res.data.order
                this.$store.commit('setOrder', order)
                this.$store.commit('setUser', res.data.user)
                this.$store.commit('setTimetable', order.timetable)
                order.order_items.forEach(item => {
                    let sign = "+"
                    let ticket = {
                        seat_id: item.seat_id,
                        section_id: item.section_id,
                        row: item.row,
                        seat: item.seat,
                        price: item.price,
                        section_name: item.section ? item.section.title : {}
                    }
                    this.$store.commit('updateCart', { sign, ticket })
                })
                this.form.name = order.name
                this.form.email = order.email
                this.form.phone = order.phone
                if (!order.name) {
                    this.populateFromUser()
                }
                this.launchTimer()
            })
        },
        populateFromUser() {
            if (this.user) {
                this.form.name = this.user.name
                this.form.email = this.user.email
                this.form.phone = this.user.phone
            }
        },
        orderFill() {
            if (this.order.pay_url) {
                window.location = this.order.pay_url
                return
            }
            window.loaderIcon()
            axios.post(`/api/order/${this.order.id}/${this.order.hash}/fill`, {
                ...this.form,
                timetable_id: this.timetable.id
            }).then(res => {
                let d = res.data
                if (d && d.success && d.redirect) {
                    window.location = d.redirect
                    return
                }
                if (d && d.error) {
                    window.noty(d.error, 'error')
                    return
                }
                if (d && d.success && this.form.pay_system == 'card') {
                    this.launchCloudPay()
                    return
                }
                window.noty('Что-то пошло не так', 'error')
            })
        },
        cancelOrder() {
            window.loaderIcon()
            axios.delete(`/api/order/${this.order.id}/${this.order.hash}`).then(res => {
                this.$router.push('/')
            })
        },
        countdown() {
            if (!this.order) return
            let now = moment(new Date());
            let end = moment(this.order.created_at)
            this.$store.commit('setCheckoutTime', Math.round(this.timeToCheckout - moment.duration(now.diff(end)).asSeconds()))
            if (this.checkouttime <= 0 && this.timer) {
                clearInterval(this.timer)
            }
        },
        launchCloudPay() {
            let order = this.order
            console.log('asd')
            window.noty('Спасибо!', 'Успешно выдано - билеты будут отправлены Вам на указанный email.');
            axios.get(`/admin/order/${this.order.id}/ticket/withoutpay/send`).then(res => {
                console.log('success')
            })
            setTimeout(() => {
                window.location = `${window.location.origin}/order/${order.id}/${order.hash}/pdf`
            }, 500)

        }
    },
    data() {
        return {
            form: {
                name: '',
                email: '',
                phone: '',
                pay_system: 'card',
            },
            timeToCheckout: 30 * 60,
            timer: null,
        }
    },
    metaInfo() {
        return {
            title: 'Оформление заказа',
            meta: []
        }
    }
}
</script>

<style scoped></style>
