<template>
    <div>
        <div class="container-fluid" v-if="fade">
            <div class="row">
                <div class="col-6">
                    <h6>
                        Сектор {{ section.title.ru }}
                        <span v-if="section.scheme && section.scheme.venue">
                            ({{ section.scheme.venue.title.ru }}, {{ section.scheme.title.ru }})
                        </span>
                    </h6>
                    <section-scheme :seats="section.seats"
                                    :selectedSeats="selectedSeats"
                                    :mouse-selectable="true"
                                    @rowPressed="rowPressed"
                                    @maxRow="maxRow"
                                    @seatPressed="seatPressed"/>
                </div>
                <div class="col-6">
                    <div class="text-right">
                        <router-link :to="'/scheme/'+section.venue_scheme_id" class="btn btn-outline btn-themed btn-secondary">К площадке</router-link>
                        <a @click="save" class="btn btn-info btn-themed btn-fill ml-2">Сохранить</a>
                    </div>

                    <div class="row align-items-center">
                        <div class="col-2 mb-2">Мест в ряду</div>
                        <div class="col-4 mb-2"><input type="number" v-model="seatsInRow" class="form-control"/></div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-2 mb-2">След ряд</div>
                        <div class="col-4 mb-2"><input type="number" v-model="nextRow" class="form-control"/></div>
                        <div class="col-2 mb-2">След место</div>
                        <div class="col-4 mb-2"><input type="number" v-model="nextSeat" class="form-control"/></div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-2 mb-2">Отступ слева</div>
                        <div class="col-4 mb-2"><input type="number" v-model="standardOffset" class="form-control"/></div>
                        <div class="col-2 mb-2">Отступ движения</div>
                        <div class="col-4 mb-2"><input type="number" v-model="moveValue" class="form-control"/></div>
                    </div>
                    <div>
                        <div class="mb-2 mt-3">
                            <a tabindex="#" v-if="selectedSeats.length > 0" class="btn btn-themed btn-outline btn-danger" @click="deleteSelected">Удалить выделенное</a>
                            <a v-if="selectedSeats.length > 0" class="btn btn-outline btn-themed btn-secondary" @click="removeSelection">Снять выделение</a>
                        </div>
                        <a @click="addRow" class="btn btn-outline btn-themed btn-secondary">+ ряд</a>
                        <a @click="addSeat" class="btn btn-outline btn-themed btn-secondary ml-2">+ место</a>
                        <a v-if="selectedSeats.length > 0" @click="move('left')" class="btn btn-outline btn-themed btn-secondary"><i class="ti-arrow-circle-left"></i></a>
                        <a v-if="selectedSeats.length > 0" @click="move('right')" class="btn btn-outline btn-themed btn-secondary"><i class="ti-arrow-circle-right"></i></a>
                        <a v-if="selectedSeats.length > 0" @click="move('up')" class="btn btn-outline btn-themed btn-secondary"><i class="ti-arrow-circle-up"></i></a>
                        <a v-if="selectedSeats.length > 0" @click="move('down')" class="btn btn-outline btn-themed btn-secondary"><i class="ti-arrow-circle-down"></i></a>
                        <div v-if="lastSeat">
                            <div class="mt-4 mb-2">Последнее место:</div>
                            <div class="row align-items-center">
                                <div class="col-2 mb-2">Ряд</div>
                                <div class="col-4 mb-2"><input type="number" v-model="lastSeat.row" class="form-control"/></div>
                                <div class="col-2 mb-2">Место</div>
                                <div class="col-4 mb-2"><input type="number" v-model="lastSeat.seat" class="form-control"/></div>
                                <div class="col-2 mb-2">X</div>
                                <div class="col-4 mb-2"><input type="number" v-model="lastSeat.x" class="form-control"/></div>
                                <div class="col-2 mb-2">Y</div>
                                <div class="col-4 mb-2"><input type="number" v-model="lastSeat.y" class="form-control"/></div>
                            </div>
                        </div>
                        <div v-if="selectedSeats.length > 0">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

    import SectionScheme from "../../app/components/SectionScheme"

    export default {
        components: {
            SectionScheme
        },
        mounted() {
            this.loadSeats()
        },
        methods: {
            loadSeats() {
                axios.get('/admin/section/'+this.$route.params.id).then(res => {
                    this.fade = true
                    this.section = res.data
                })
            },
            save() {
                axios.post('/admin/section/'+this.$route.params.id, this.section).then(res => {
                    this.section = res.data
                    this.lastSeat = null
                    this.selectedSeats = []
                    window.noty()
                })
            },
            addRow() {
                for(var i = 1; i <= this.seatsInRow; i++) {
                    this.section.seats.push({
                        row: this.nextRow,
                        seat: i,
                        x: this.standardOffset + (i * (this.widthOfSeat + this.marginBetweenSeats)),
                        y: this.nextRow * (this.widthOfSeat + this.marginBetweenSeats)
                    })
                }
                this.save()
            },
            addSeat() {
                this.section.seats.push({
                    row: this.nextRow,
                    seat: this.nextSeat,
                    x: this.standardOffset + (this.nextSeat * (this.widthOfSeat + this.marginBetweenSeats)),
                    y: this.nextRow * (this.widthOfSeat + this.marginBetweenSeats)
                })
                this.nextSeat++
                this.save()
            },
            seatPressed(seat) {
                if(!seat.id) { return }
                const exists = this.selectedSeats.includes(seat.id)
                if (exists) {
                    this.selectedSeats = this.selectedSeats.filter((c) => { return c !== seat.id })
                    this.lastSeat = null
                } else {
                    this.selectedSeats.push(seat.id)
                    this.lastSeat = seat
                }
            },
            rowPressed(row) {
                this.section.seats.forEach((item) => {
                    if(item.row == row) {
                        this.seatPressed(item)
                    }
                })
            },
            deleteSelected() {
                axios.post('/admin/section/'+this.$route.params.id+'/deleteSeats', { seats: this.selectedSeats }).then(res => {
                    this.section = res.data
                    this.selectedSeats = []
                    window.noty()
                })
            },
            maxRow(row) {
                this.nextRow = row ? (row + 1) : 1
            },
            move(direction) {
                this.moveValue = parseInt(this.moveValue)
                this.section.seats.forEach((item) => {
                    if(this.selectedSeats.includes(item.id)) {
                        switch(direction) {
                            case 'left':
                                item.x = item.x - this.moveValue;
                                break;
                            case 'right':
                                item.x = item.x + this.moveValue;
                                break;
                            case 'up':
                                item.y = item.y - this.moveValue;
                                break;
                            case 'down':
                                item.y = item.y + this.moveValue;
                                break;

                        }
                    }
                })
            },
            removeSelection() {
                this.selectedSeats = []
                this.lastSeat = null
            }
        },
        watch:{
            $route (to, from) {

            },
            selectedSeats(val) {

            }

        },
        computed: {
        },
        props: {
        },
        data: function() {
            return {
                lastSeat: null,
                section: null,
                fade: false,
                rows: [],
                nextRow: 1,
                nextSeat: 1,
                standardOffset: 40,
                seatsInRow: 10,
                moveValue: 10,
                widthOfSeat: 30,
                marginBetweenSeats: 6,
                selectedSeats: [],
            }
        }
    }
</script>

<style scoped>

</style>