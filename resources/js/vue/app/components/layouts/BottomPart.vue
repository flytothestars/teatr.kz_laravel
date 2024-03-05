<template>
    <div class="text-center bottom-part__content" v-if="step > 1">
        <template v-if="cart" v-for="item in cart">
            <div class="row justify-content-around mb-5">
                <div class="col-md-5 text-center seat-bg">{{ item.section_name.ru }}</div>
                <div class="col-md-5 text-center seat-bg">Ряд: {{ item.row }}, {{ item.seat }} место - {{ item.price }} </div>
            </div>
        </template>

        <template v-if="step > 1 && step < 3 && cart.length > 0">
            <p class="h5 text-left ml-3">Введите данные</p>
            <div class="row justify-content-around mb-2">
                <input  placeholder="Введите E-mail" type="text" class="input-themed col-md-5">
                <input placeholder="Введите номер телефона" type="text" class="input-themed col-md-5">
            </div>
        </template>

        <!-- <a v-if="step > 1 && step < 3 && !(step == 2 && timetable.type == 'pricegroups')" @click="back" class="btn btn-themed-secondary bottom-btn">
            Назад
        </a> -->
        <a v-if="step == 3 && order" @click="cancelOrder" class="btn btn-themed-secondary bottom-btn">
            Отменить
        </a>
        <a v-if="step > 1 && step < 3 && cart.length > 0" @click="checkout" class="btn button-themed bottom-btn my-4 pb-5">
            Оформить
        </a>
        <a v-if="step == 3 && order && checkouttime > 0" @click="fillOrder" class="btn button-themed bottom-btn my-4 pb-5">
            <span class=" d-none">Перейти к оплате</span>
            <span class=" d-inline">К оплате</span>
        </a>
        <p  class="offert">Нажимая “Оплатить”, вы соглашаетесь</p>
         <p class="offert"><a href="">с условиями приобретения</a> и <a href="">офертой</a></p>
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
.offert{
    margin-bottom: 4px;
    color: #A5ABB7;
    a{
        color: #3BA1FF;
        cursor: pointer;
    }
}

.btn-themed-secondary, .btn-themed {
    font-size: 14px;
}
.seat-bg{
    background: #CEE8FF;
    padding: 24px 16px;
    border-radius: 16px;
    @media (max-width: 768px){
        margin-bottom: 10px;
    }
}
.input-themed{
    align-items: center;
    width: 80%;
    padding: 24px 16px;
    margin:  auto;
    background: #fff;
    border-radius: 16px;
    font-size: 20px;
    border: 1px solid #AEB3DB;
    @media (max-width: 768px){
        margin-bottom: 10px;
        width: 100%;
    }
}
.button-themed{
    align-items: center;
    width: 80%;
    height: 56px;
    padding: 24px 16px;
    margin:  auto;
    background: #FFC737;
    border-radius: 16px;
    font-size: 20px;
    @media (max-width: 768px){
        margin-bottom: 10px;
        width: 100%;
    }
}
.bottom-part__content{
    @media (max-width: 768px){
        flex-direction: column;
        div{
            flex-direction: column;
        }
    }
}

</style>
