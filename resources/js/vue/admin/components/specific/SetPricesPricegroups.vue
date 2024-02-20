<template>
    <div>
        <div class="mb-3">Ценовые группы:</div>
        <div v-for="(p, pind) in pricegroups" class="mb-3">
            <div class="row">
                <div class="col-3">
                    <input type="text" class="form-control" v-model="p.title.ru" placeholder="Название"/>
                </div>
                <div class="col-2">
                    <input type="number" class="form-control" v-model="p.amount" placeholder="Кол-во билетов"/>
                </div>
                <div class="col-2">
                    <input type="number" class="form-control" v-model="p.price" placeholder="Цена"/>
                </div>
                <div class="col-3">
                    <a class="btn btn-info btn-themed btn-fill" @click="savePricegroup(p)">Сохранить</a>
                    <a tabindex="#" class="btn btn-themed btn-outline btn-danger ml-2" @click="deletePricegroup(p, pind)">Удалить</a>
                </div>
            </div>
        </div>
        <div class="text-left">
            <a class="btn btn-themed btn-outline btn-secondary" @click="addPricegroup">Добавить</a>
        </div>
    </div>

</template>

<script>
    export default {
        name: "SetPricesPricegroups",
        props: {
            ticketsCount: {
                type: Object
            },
            timetable: {
                type: Object
            },
        },
        methods: {
            addPricegroup() {
                this.pricegroups.push({
                    title: {
                        ru: '',
                        kz: ''
                    },
                    price: '',
                    amount: ''
                })
            },
            getPricegroups() {
                axios.get('/admin/timetable/'+this.timetable.id+'/pricegroups').then(res => {
                    this.pricegroups = res.data
                })
            },
            savePricegroup(pricegroup) {
                axios.post('/admin/timetable/'+this.timetable.id+'/pricegroups', pricegroup).then(res => {
                    this.pricegroups = res.data
                    window.noty()
                })
            },
            deletePricegroup(pricegroup, index) {
                if(pricegroup.id) {
                    axios.delete('/admin/timetable/'+this.timetable.id+'/pricegroups/'+pricegroup.id).then(res => {
                        this.pricegroups = res.data
                        window.noty()
                    })
                }
                if(!pricegroup.id) {
                    this.$delete(this.pricegroups, index)
                    // this.pricegroups.splice()
                }
            }
        },
        mounted() {
            this.getPricegroups()
        },
        data() {
            return {
                pricegroups: []
            }
        }
    }
</script>

<style scoped>

</style>