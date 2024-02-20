<template>
    <a class="btn" @click="orderDetails">
        <i class='ti-eye grey-color' data-toggle='tooltip' title='Детали заказа'></i>
    </a>
</template>

<script>
    export default {
        name: "OrderTDLinkComponent",
        props: {
            object: {
                type: Object
            }
        },
        methods: {
            orderDetails() {
                window.loaderIcon()
                axios.get('/admin/order/'+this.object.id+'/details').then(res => {
                    $('#custommodalbody').html(res.data.html);
                    $('#custommodal').modal();
                })
            }
        }
    }
</script>

<style scoped>

</style>