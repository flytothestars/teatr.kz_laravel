<template>
    <div class="zoom-block">
        <a @click="zoomIn"><zoom-out-svg/></a>
        <a @click="zoomOut"><zoom-in-svg/></a>
    </div>
</template>

<script>
    import ZoomInSvg from '../../../../../public/images/zoom-in.svg'
    import ZoomOutSvg from '../../../../../public/images/zoom-out.svg'

    export default {
        name: "ZoomBlock",
        components: {
            ZoomInSvg,
            ZoomOutSvg,
        },
        methods: {
            zoomIn() {
                this.$parent.scale = Math.max(0.4, (this.$parent.scale - 0.2))
            },
            zoomOut() {
                this.$parent.scale = Math.min(3, (this.$parent.scale + 0.2))
            }
        }
    }
</script>

<style scoped>

</style>