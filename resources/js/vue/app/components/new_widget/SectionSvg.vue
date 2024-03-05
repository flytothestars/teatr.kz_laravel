<template>
    <!-- <div class="">{{ props }}</div> -->
    <g class="section" v-if="section.svg">
        <path stroke="black"
              :stroke-width="selected ? '4' : '0'"
              :fill="section.svg.color"
              :d="'M'+section.svg.points.join(' l')+'z'"></path>
        <text text-anchor="middle"
              :style="`transform: rotate(${section.svg.text[2] ? section.svg.text[2] : 0}deg);`"
              :x="section.svg.text[0]"
              :y="section.svg.text[1]">
            {{ section.title.ru }}
        </text>
    </g>
</template>

<script>
    export default {
        props: {
            section: {
                type: Object,
                required: true
            },
            selected: {
                type: Boolean,
                default: false,
            }
        },
        name: "SectionSvg"
    }
</script>

<style scoped>

</style>