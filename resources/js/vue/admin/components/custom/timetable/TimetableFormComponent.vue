<template>
    <div class="col-md-12">
        <div class="form-group">
            <label for="venue_id" class="required">Площадка</label>
            <select class="form-control" id="venue_id" name="venue_id">
                <option value="">-</option>
                <option v-for="d in select_models.venue_id" :selected="object.venue_id == d.id" :value="d.id">
                    [{{ d.id }}] {{ d.title.ru }}
                </option>
            </select>
        </div>
        <div class="form-group">
            <label for="venue_scheme_id" class="required">Рассадка</label>
            <select class="form-control" id="venue_scheme_id" name="venue_scheme_id" v-if="schemes[selectedVenue]">
                <option value="">-</option>
                <option v-for="d in schemes[selectedVenue]" :selected="object.venue_scheme_id == d.id" :value="d.id">
                    [{{ d.id }}] {{ d.title.ru }}
                </option>
            </select>
        </div>
    </div>
</template>

<script>
    export default {
        name: "TimetableFormComponent",
        props: {
            object: {
                type: Object,
            },
            select_models: {
            }
        },
        mounted() {
            $('#venue_id').select2().on('select2:select', (e) => {
                this.selectedVenue = e.params.data.id
            })
            this.loadSchemes()
        },
        methods: {
            loadSchemes() {
                axios.get('/admin/schemes').then(res => {
                    this.schemes = res.data
                })
            }
        },
        data() {
            return {
                schemes: {},
                selectedVenue: this.object.venue_id
            }
        }
    }
</script>

<style scoped>

</style>