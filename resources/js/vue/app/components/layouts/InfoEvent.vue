<template>
    <div class="info">
        <div class="row">
            <div class="col-4">
                <div class="event__image">
                    <img src="" />
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="event__name">
                        <h5><b>Золотой квадрат</b></h5>
                    </div>
                    <div class="event__time">
                        <p>Дата события: 25 мар. - 20:00</p>
                    </div>
                    <div class="event__place">
                        <p>Место проведения: пр. Абая, 43 </p>
                    </div>
                    <div class="event__price">
                        <p>Цены на билеты: 8 000 ₸ - 28 000 ₸</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import { mapState } from 'vuex'

    export default {
        computed: {
            ...mapState(['step','cart','order','timetable'])
        },
        data() {
            return {
                menu: [
                    // { title: 'Расписание', mob_title: "Расписание", note: 'Выберите дату мероприятия' },
                    { title: 'Схема зала', mob_title: "Зал", note: 'Выберите сектор' },
                    { title: 'Схема сектора', mob_title: "Сектор", note: 'Выберите места' },
                    { title: 'Оформление', mob_title: "Оформление", note: 'Оплата' },
                ]
            }
        },
        methods: {
            stepClicked(step) {
                if(this.step == 3) {
                    return
                }
                // if(step == 1) {
                //     this.$router.push('/')
                // }
                if(step == 1 && this.timetable && this.timetable.type == 'pricegroups') {
                    return
                }
                if(step == 1 && this.step == 2) {
                    this.$store.commit('setStep', 1)
                }
                if(step == 3 && this.cart.length > 0) {
                    this.$store.dispatch('generateOrder').then(res => {
                        this.$router.push('/order/'+res.id+'/'+res.hash)
                    })
                }
            }
        }
    }
</script>

<style scoped>

</style>
