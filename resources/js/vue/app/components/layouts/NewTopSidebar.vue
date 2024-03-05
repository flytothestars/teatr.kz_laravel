<template>
    <div class="newtop-sidebar">
        <div class="d-flex justify-content-start mt-3 pl-3">
            <div :class="{ active: step === (mind + 1) }" class="top__item" v-for="(m, mind) in menu">
                <div  @click="stepClicked((mind + 1))">
                    <!-- <div class="newtop__title d-md-block d-none">{{ m.title }}<img v-if="mind != 2" src="../../../../../img/Arrow - Right.png"/></div> -->
                    <!-- <div class="newtop__title d-md-none d-block">{{ m.mob_title }}<img v-if="mind != 2" src="../../../../../img/Arrow - Right.png"/></div> -->
                    <div class="newtop__subtitle d-block d-none">{{ m.note }} <img v-if="mind != 2" src="../../../../../img/Arrow - Right.png"/></div>
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

<style scoped lang="scss">
    .top__item{
        width: auto;
        padding: 0;
    }
    .newtop__subtitle{
        display: flex;
        width: auto;
        img{
            width: 24px;
        }
        @media (max-width: 575px) {
            font-size: 14px;
    }
    }
</style>
