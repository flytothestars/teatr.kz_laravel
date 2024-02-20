<template>
    <div class="w-100">
        <div class="font-weight-bolder container mb-2">Укажите на карте</div>
        <div id="yamap" class="mx-auto"></div>
        <input type="hidden" name="x_coord" id="x_coord" :value="x"/>
        <input type="hidden" name="y_coord" id="y_coord" :value="y"/>
    </div>
</template>

<script>
    export default {
        mounted() {

            const _this = this
            _this.x = this.object.x_coord ? this.object.x_coord : 43.267902
            _this.y = this.object.y_coord ? this.object.y_coord : 76.931886

            this.$nextTick(() => {
                $.getScript( "https://api-maps.yandex.ru/2.1/?apikey=897e0489-4658-4915-b7b2-eaa365324138&lang=ru_RU" ).done(function( script, textStatus ) {
                    $(function() {
                        ymaps.ready(init);
                        var myMap, myPlacemark, x_coord, y_coord;
                        // x_coord = 43.267902;
                        // y_coord = 76.931886;
                        function init() {
                            myMap = new ymaps.Map("yamap", {
                                // center: [x_coord, y_coord],
                                center: [_this.x, _this.y],
                                zoom: 15,
                                controls: ['zoomControl']
                            });
                            myPlacemark = new ymaps.Placemark([_this.x, _this.y], {
                                hintContent: 'Saubol',
                            });
                            myMap.geoObjects.add(myPlacemark);
                            myMap.behaviors.disable('scrollZoom');


                            myMap.events.add('click', function (e) {
                                var coords = e.get('coords');
                                x_coord = coords[0];
                                y_coord = coords[1];
                                _this.x = x_coord
                                _this.y = y_coord
                                myMap.geoObjects.remove(myPlacemark)
                                myPlacemark = new ymaps.Placemark([x_coord, y_coord], { hintContent: _this.object.address_ru});
                                myMap.geoObjects.add(myPlacemark);
                            });

                        }
                    })
                });
            })

        },
        methods: {

        },
        props: {
            object: { required: true }
        },
        data: function() {
            return {
                x: null,
                y: null
            }
        }
    }
</script>

<style scoped>
    #yamap {
        height: 300px;
        width: 100%;
    }
</style>
