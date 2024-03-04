<template>
    <div class="text-center mt-5">
        <div>
            Выберите количество билетов в секторе <b>{{ transName(section.title) }}</b>
        </div>
        <div>Цена: <b>{{ tickets[0].price | formatNumber }}</b></div>
        <div class="text-center mt-3">
            <a class="plus-btn" @click="changeAmount('-')">-</a>
            {{ amount }}
            <a class="minus-btn" @click="changeAmount('+')">+</a>
        </div>
    </div>
</template>

<script>
    import { mapState } from 'vuex'
    import { tickets_limit } from '../../../../config'

    export default {
        name: "SelectEnterSectionTicketsAmount",
        props: {
            tickets: {
                type: Array
            },
            section: {
                type: Object
            },
        },
        computed: {
            ...mapState(['cart']),
            max() {
                return Math.min(this.tickets.length, tickets_limit)
            },
            amount() {
                return this.cart.reduce((a, v) => (v.section_id === this.section.id ? a + 1 : a), 0)
            }
        },
        methods: {
            changeAmount(sign) {
                if(sign === '+' && this.amount >= this.max) return
                if(sign === '-' && this.amount <= 0) return
                let ticket = {
                    price: this.tickets[0].price,
                    section_id: this.section.id
                }
                ticket.section_name = this.section.title
                this.$store.commit('updateCart', { sign, ticket })
            }
        }
    }
</script>

<style scoped>

</style>