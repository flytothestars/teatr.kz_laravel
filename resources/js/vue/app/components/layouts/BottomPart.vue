<template>
    <div class="text-md-right bottom-part__content" v-if="step > 1">
        <a v-if="step > 1 && step < 3 && !(step == 2 && timetable.type == 'pricegroups')" @click="back" class="btn btn-themed-secondary bottom-btn">
            Назад
        </a>
        <a v-if="step == 3 && order" @click="cancelOrder" class="btn btn-themed-secondary bottom-btn">
            Отменить
        </a>
        <a v-if="step > 1 && step < 3 && cart.length > 0" @click="checkout" class="btn btn-themed bottom-btn ml-2">
            Оформить
        </a>
        <a v-if="step == 3 && order && checkouttime > 0" @click="fillOrder" class="btn btn-themed bottom-btn ml-2">
            <span class="d-md-inline d-none">Перейти к оплате</span>
            <span class="d-md-none d-inline">К оплате</span>
        </a>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import EventBus from '../../../../event-bus'

export default {
    name: "BottomPart",
    computed: {
        ...mapState(['step','cart','order','timetable','checkouttime'])
    },
    methods: {
        back() {
            if(this.step == 1) {
                this.$router.push('/')
            }
            if(this.step == 2) {
                if(this.timetable && this.timetable.type == 'pricegroups') {
                    this.$router.push('/')
                } else {
                    this.$store.commit('setStep', 1)
                }

            }
        },
        checkout() {
            this.$store.dispatch('generateOrder').then(res => {
                window.loaderIcon(false)
                this.$router.push('/order/'+res.id+'/'+res.hash)
            })
        },
        cancelOrder() {
            if(!this.order) return
            window.loaderIcon()
            axios.delete(`/api/order/${this.order.id}/${this.order.hash}`).then(res => {
                this.$store.commit('setOrder', null)
                this.$store.commit('emptyCart')
                // location.href = `/widget#/${this.timetable.event_id}/${this.timetable.id}`
                this.$store.commit('setStep', 1)
                this.$router.push(`/${this.timetable.event_id}/${this.timetable.id}`)

            })
        },
        fillOrder() {
            EventBus.$emit('fillOrder');
        }
    }
}
</script>

<style scoped lang="scss">
.btn-themed-secondary, .btn-themed {
    font-size: 14px;
}
</style>
