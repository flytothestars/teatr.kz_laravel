<template>
    <div v-if="timetable">
        <div v-if="timetable.type == 'sections'">
            <select-tickets-sections/>
        </div>
        <div v-if="timetable.type == 'pricegroups'">
            <select-tickets-pricegroups/>
        </div>
    </div>
</template>

<script>
    import { mapState } from 'vuex'

    export default {
        created() {
            this.loadTimetable()
        },
        methods: {
            loadTimetable() {
                if(!this.tid) {
                    return
                }
                window.loaderIcon()
                axios.get('/api/timetable/'+this.tid).then(res => {
                    this.$store.commit('setVenue', res.data.venue)
                    this.$store.commit('setScheme', res.data.scheme)
                    this.$store.commit('setTimetable', res.data.timetable)
                    this.$store.commit('setPricegroups', res.data.tickets)
                    this.$store.commit('setEvent', res.data.timetable.event)
                    this.$store.commit('setStep', 1)
                })
            }
        },
        computed: {
            ...mapState(['timetable','event'])
        },
        data() {
            return {
                tid: this.$route.params.timetableid,
                fade: false,
                selectedSectionIndex: null
            }
        },
        metaInfo() {
            return {
                title: (this.event && this.timetable) ? (this.transName(this.event.title) + ' - '+this.timetable.datetime) : '',
                meta: []
            }
        }
    }
</script>

<style scoped>

</style>
