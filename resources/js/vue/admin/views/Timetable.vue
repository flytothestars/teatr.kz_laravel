<template>
    <div>
        <div class="container-fluid" v-if="fade">
            <h6>{{ timetable.event.title.ru }} - {{ venue.title.ru }}: {{ timetable.datetime | formatDate }}</h6>
            <hr/>
            <set-prices-sections v-if="timetable.type == 'sections'"
                                 :venue="venue"
                                 :scheme="scheme"
                                 :ticketsCount="ticketsCount"
                                 :timetable="timetable">
            </set-prices-sections>
            <set-prices-pricegroups v-if="timetable.type == 'pricegroups'"
                                    :venue="venue"
                                    :scheme="scheme"
                                    :ticketsCount="ticketsCount"
                                    :timetable="timetable">
            </set-prices-pricegroups>
        </div>
    </div>
</template>

<script>

    export default {
        mounted() {
            this.loadTimetable()
            $('.tooltip').hide();
        },
        methods: {
            loadTimetable() {
                axios.get('/admin/timetable/'+this.$route.params.id).then(res => {
                    this.fade = true
                    this.timetable = res.data.timetable
                    this.venue = res.data.venue
                    this.scheme = res.data.scheme
                    this.ticketsCount = Array.isArray(res.data.tickets) ? {} : res.data.tickets
                })
            },
        },

        computed: {
        },
        props: {
        },
        data() {
            return {
                timetable: null,
                venue: null,
                scheme: null,
                ticketsCount: null,
                fade: false,
            }
        },
    }
</script>

<style scoped>

</style>