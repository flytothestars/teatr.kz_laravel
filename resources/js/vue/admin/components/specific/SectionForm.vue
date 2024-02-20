<template>
    <div class="bg-white p-3 mt-2 border">
        <div>
            <div class="row align-items-center">
                <div class="col-2">
                    Название
                </div>
                <div class="col-10">
                    <input class="form-control" v-model="section.title.ru"/>
                </div>
            </div>
            <div class="row align-items-center mt-2">
                <div class="col-2">
                    Цвет
                </div>
                <div class="col-6">
                    <input class="form-control" v-model="section.svg.color"/>
                </div>
                <div class="col-4">
                    <div class="checkbox-wrapper">
                        <input type="checkbox" :id="'for-sale-'+section.id" v-model="section.for_sale" value="1"/>
                        <label :for="'for-sale-'+section.id">Для продажи</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="row align-items-center mt-2">
            <div class="col-4">
                Точка названия:
            </div>
            <div class="col-3">
                <input type="number" v-model="section.svg.text[0]" class="form-control"/>
            </div>
            <div class="col-3">
                <input type="number" v-model="section.svg.text[1]" class="form-control"/>
            </div>
            <div class="col-2">
                <input type="number" v-model="section.svg.text[2]" class="form-control"/>
            </div>
        </div>

        <div class="mt-4">
            <div v-for="(p, pind) in section.svg.points">

                <div class="row align-items-center mt-1">
                    <div class="col-4">Точка {{ pind }}: ({{ cumulativeX(pind) }} {{ cumulativeY(pind) }})</div>
                    <div class="col-3">
                        <input type="number" v-model="p[0]" class="form-control"/>
                    </div>
                    <div class="col-3">
                        <input type="number" v-model="p[1]" class="form-control"/>
                    </div>
                    <div class="col-2">
                        <a @click="removePoint(pind)"><i class="ti-trash"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="mt-3">
            <!--        <a @click="$emit('addPoint')" class="mt-2 btn btn-secondary text-white d-inline-block">+ точку</a>-->
            <a @click="addPoint" class="btn btn-outline btn-themed btn-secondary">+ точку</a>
            <a @click="deleteSection" class="btn btn-outline btn-themed btn-danger"><i class="ti-trash"></i></a>
            <router-link class="btn btn-outline btn-themed btn-secondary ml-2" v-if="section.id" :to="'/section/'+section.id">План сектора</router-link>
        </div>
    </div>
</template>

<script>
    export default {
        props: {
            section: {
                type: Object,
                required: true
            },
        },
        methods: {
            addPoint() {
                this.section.svg.points.push([50,50])
            },
            removePoint(point_index) {
                this.$delete(this.section.svg.points, point_index)
            },
            deleteSection() {
                this.$emit('deleteSection', this.section)
            },
            cumulativeX(index) {
                return this.section.svg.points.reduce((a, v, i) => (a = a + (i <= index ? parseInt(v[0]) : 0), a), 0)
            },
            cumulativeY(index) {
                return this.section.svg.points.reduce((a, v, i) => (a = a + (i <= index ? parseInt(v[1]) : 0), a), 0)
            }
        },
        name: "SectionForm"
    }
</script>

<style scoped>

</style>