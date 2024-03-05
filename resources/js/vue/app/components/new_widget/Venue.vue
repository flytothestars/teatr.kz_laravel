<template>
    <div class="position-relative">
        <zoom-block/>
        <div class="venue-wrapper">
            <svg class="w-100 position-absolute" :viewBox="'0 0 600 600'" :style="`transform: scale(${scale})`">
                <template v-for="(s, sind) in scheme.sections">
                    <SectionSvg @click.native="selectSector(sind, s)"
                                :section="s"
                                :class="{ 'blocked': sectorIsBlocked(s) && s.for_sale, 'not_for_sale': !s.for_sale }"
                                :data-toggle="view == 'user' && s.for_sale ? 'tooltip' : ''"
                                :title="`${pricegroups && pricegroups[s.id] ? 'Билетов: '+pricegroups[s.id].cnt : 'Билетов нет'}`"
                                :selected="selectedSectionIndex === sind"
                                :key="'path-'+sind"/>
                </template>
            </svg>
        </div>
    </div>
</template>

<script>
    import SectionSvg from '../../../app/components/SectionSvg'
    import ZoomBlock from "../../../app/components/ZoomBlock"
    import { mapState } from 'vuex'

    export default {
        components: {
            ZoomBlock,
            SectionSvg
        },
        mounted() {
            $('[data-toggle="tooltip"]').tooltip()
        },
        methods: {
            selectSector(index, section) {
                if(this.sectorIsBlocked(section)) {
                    return
                }
                $('.tooltip').hide()
                this.$parent.selectedSectionIndex = (index == this.selectedSectionIndex) ? null : index
            },
            sectorIsBlocked(section) {
                if(this.view === 'admin') {
                    return false
                }
                return !(this.pricegroups && this.pricegroups[section.id] && this.pricegroups[section.id].cnt > 0)
            }
        },
        watch:{
        },
        computed: {
            ...mapState(['pricegroups'])
        },
        props: {
            scheme: {
                type: Object,
                required: true
            },
            selectedSectionIndex: {
                type: Number,
                default: null
            },
            view: {
                type: String,
                default: "user"
            }
        },
        data: function() {
            return {
                timetable: null,
                fade: false,
                scale: 1,
            }
        }
    }
</script>

<style scoped lang="scss">

</style>