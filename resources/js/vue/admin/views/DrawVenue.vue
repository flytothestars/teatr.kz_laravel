<template>
    <div>
        <div class="container-fluid" v-if="fade">
            <h6>{{ venue.title.ru }} ({{ scheme.title.ru }})</h6>
            <hr/>
            <div class="row">
                <div class="col-6">
                    <Venue :scheme="scheme"
                           view="admin"
                           :selectedSectionIndex="selectedSectionIndex"/>
                </div>
                <div class="col-6 ">
                    <div class="text-right">
                        <button @click="addSection" class="btn btn-outline btn-themed btn-secondary">+ сектор</button>
                        <button @click="save" class="ml-2 btn btn-info btn-themed btn-fill">Сохранить</button>
                    </div>
                    <div v-if="selectedSectionIndex !== null">
                        <section-form :section="scheme.sections[selectedSectionIndex]"
                                      @deleteSection="deleteSection"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Venue from '../../app/components/Venue'

    export default {
        components: {
            Venue
        },
        mounted() {
            this.loadVenue()
        },
        methods: {
            loadVenue() {
                axios.get('/admin/scheme/'+this.$route.params.id).then(res => {
                    this.fade = true
                    this.scheme = res.data
                    this.venue = res.data.venue
                })
            },
            addSection() {
                this.scheme.sections.push({
                    title: {
                        'ru': '1',
                        'kz' : '1'
                    },
                    svg: {
                        points: [
                            [0,0],
                            [100,0],
                            [0,100],
                            [-100,0],
                        ],
                        text: [50,60],
                        color: '#f4500d',
                    },
                    for_sale: 1
                })
                this.selectedSectionIndex = (this.scheme.sections.length - 1)
            },
            deleteSection(section) {
                axios.delete('/admin/scheme/'+section.id).then(res => {
                    this.scheme = res.data
                    this.selectedSectionIndex = null
                    window.noty()
                })
            },
            save() {
                axios.post('/admin/scheme/'+this.$route.params.id, this.scheme).then(res => {
                    this.scheme = res.data
                    window.noty()
                })
            },
        },
        watch:{
            $route (to, from) {

            },

        },
        computed: {
        },
        props: {
        },
        data: function() {
            return {
                scheme: null,
                venue: null,
                fade: false,
                selectedSectionIndex: null,
            }
        }
    }
</script>

<style scoped>

</style>