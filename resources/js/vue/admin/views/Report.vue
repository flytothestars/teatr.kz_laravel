<template>
    <div>
        <div class="container-fluid" v-if="fade">
            <div class="row align-items-center">
                <div class="col-6">
                    <h6 class="mb-0">Сформировать отчет</h6>
                </div>
            </div>
            <hr>
            <div style="max-width: 600px;">
                <div class="container mr-auto ml-0 px-0">
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="date_from">Дата от</label>
                                <datetime type="date"
                                          format="yyyy-MM-dd"
                                          :value-zone="'UTC+6'"
                                          :auto="true"
                                          :phrases="{ok: 'Ок','cancel': 'Отмена'}"
                                          v-model="date_from"
                                          class="form-control"
                                          id="date_from"
                                          name="date_from">
                                </datetime>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="date_to">Дата до</label>
                                <datetime type="date"
                                          format="yyyy-MM-dd"
                                          :value-zone="'UTC+6'"
                                          :auto="true"
                                          :phrases="{ok: 'Ок','cancel': 'Отмена'}"
                                          v-model="date_to"
                                          class="form-control"
                                          id="date_to"
                                          name="date_to">
                                </datetime>
                            </div>
                        </div>
                        <div class="col-12">
                            <label for="timetable_ids">Сеансы</label>
                            <select class="form-control autocomplete-select"
                                    data-model="timetable"
                                    data-field="datetime"
                                    :data-selected="'[]'"
                                    id="timetable_ids"
                                    name="timetable_ids[]"
                                    multiple>
                                <option value="">-</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-4">
                        <button class="btn btn-themed btn-info" @click="formExcel">Выгрузить</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>


    export default {
        mounted() {
            window.loaderIcon(false)
            setTimeout(() => {
                window.launchAutocomplete()
            },100)

        },
        methods: {
            formExcel() {
                let ids = $('#timetable_ids').val()
                let timetable_ids_param = ''
                ids.forEach(item => {
                    timetable_ids_param += '&timetable_ids[]='+item
                })
                let href = '/admin/report/sales/excel?date_from='+this.date_from+'&date_to='+this.date_to+timetable_ids_param
                location.href = href
            }
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
                date_to: null,
                date_from: null,
                timetable_ids: [],
                // details: null,
                fade: true,
                // timeframe: 'day'

            }
        }
    }
</script>

<style scoped>

</style>
