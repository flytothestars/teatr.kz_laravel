<template>
    <div class="left-sidebar">
        <div class="d-md-block d-none">
            <div>
                <a href="/">
                    <img src="/images/logo_w.svg" class="left__logo" alt="логотип"/>
                </a>
            </div>
            <div class="left__title" v-if="cart.length > 0">Детали заказа</div>
            <div class="left__event" v-if="event">
                <a :href="`/event/${event.slug}`">
                    {{ transName(event.title) }}
                </a>
            </div>
            <div v-if="timetable">{{ timetable.datetime | formatTimetableDate }}</div>
        </div>
        <div v-if="cart.length > 0" class="row align-items-center mt-md-3">
            <div class="col-md-12 col pt-md-0 pt-2">
                <div class="d-md-block d-none">Места:</div>
                <div v-for="c in Object.keys(cartSummary)">
                    {{ cartSummary[c] }}
                </div>
            </div>
            <div class="col-md-12 col-auto mt-md-3 pt-md-0 pt-2" v-if="getCartSum > 0">
                <div class="left__price">
                    {{ getCartSum | formatNumber }}
                </div>
            </div>
        </div>
        <div class="d-md-block d-none">
            <div class="left__title mt-5">Поддержка пользователей</div>
            <div>Если Вам требуется помощь в оформлении заказа:</div>
            <div class="mt-2" v-if="settings && settings.phone">
                <a class="d-block" :href="'tel:'+(transName(settings.phone.body)).replace(/\D/g,'')">{{ transName(settings.phone.body) }}</a>
            </div>
            <div class="mt-2" v-if="settings && settings.email">
                <a :href="'mailto: '+transName(settings.email.body)">{{ transName(settings.email.body) }}</a>
            </div>
        </div>
        <div class="d-block d-md-none">
            <bottom-part/>
        </div>
    </div>
</template>

<script>
    import { mapState, mapGetters } from 'vuex'

    export default {
        computed: {
            ...mapState(['event','cart','timetable','settings']),
            ...mapGetters(['getCartSum']),
            cartSummary() {
                let arr = {}
                let sections = {}
                let pricegroups = {}
                this.cart.forEach(item => {
                    if(item.row && item.seat) {
                        arr['seat_'+item.seat_id] = this.transName(item.section_name)+', ряд: '+item.row+', место: '+item.seat
                        // arr.push(this.transName(item.section_name)+', ряд: '+item.row+', место: '+item.seat)
                        return
                    }
                    if(item.section_id) {
                        sections[item.section_id] = (sections[item.section_id] ? sections[item.section_id] : 0) + 1
                        arr['section_'+item.section_id] = this.transName(item.section_name)+': '+sections[item.section_id]
                        return
                    }
                    if(item.pricegroup_id) {
                        pricegroups[item.pricegroup_id] = (pricegroups[item.pricegroup_id] ? pricegroups[item.pricegroup_id] : 0) + 1
                        arr['pg_'+item.pricegroup_id] = this.transName(item.pricegroup_name)+': '+pricegroups[item.pricegroup_id]
                    }
                })
                return arr
            }
        },
    }
</script>

<style scoped>

</style>
