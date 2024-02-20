<template>
    <div class="row mb-4 align-items-center">
        <div class="col">
            {{ transName(pricegroup.pricegroup.title) }}
        </div>
        <div class="col">
            {{ pricegroup.pricegroup.price | formatNumber }}
        </div>
        <div class="col-auto">
            <div>
                <a class="plus-btn" @click="changeAmount('-')">-</a>
                {{ amount }}
                <a class="minus-btn" @click="changeAmount('+')">+</a>
            </div>
        </div>
    </div>
</template>

<script>
    import { mapState } from 'vuex'
    import { tickets_limit } from '../../../config'

    export default {
        name: "SelectPricegroupTicketsAmount",
        props: {
            pricegroup: {
                type: Object
            }
        },
        computed: {
            ...mapState(['cart']),
            max() {
                return Math.min(this.pricegroup.cnt, tickets_limit)
            },
            amount() {
                return this.cart.reduce((a, v) => (v.pricegroup_id === this.pricegroup.pricegroup.id ? a + 1 : a), 0)
            }
        },
        methods: {
            changeAmount(sign) {
                if(sign === '+' && this.amount >= this.max) return
                if(sign === '-' && this.amount <= 0) return
                let ticket = {
                    price: this.pricegroup.pricegroup.price,
                    pricegroup_id: this.pricegroup.pricegroup.id
                }
                ticket.pricegroup_name = this.pricegroup.pricegroup.title
                this.$store.commit('updateCart', { sign, ticket })
            }
        }
    }
</script>

<style scoped>

</style>