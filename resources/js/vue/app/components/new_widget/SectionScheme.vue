<template>
    <div class="position-relative">
        <zoom-block/>
        <div class="venue-wrapper" >
            <div class="scheme-price-bubbles" v-if="prices.length > 0">
                <div class="scheme-price-bubble" v-for="(p, pind) in prices">
                    <span class="price-color" :class="`color-${pind}`"></span>
                    <span>{{ p | formatNumber }}</span>
                </div>
            </div>
            <div class="seats-wrapper h-100" :style="`width:${maxW}px; transform: scale(${scale})`" ref="vw" @mousedown="handleMouseDown">
                <div class="drag-area-box" :style="selectAreaStyle"></div>
                <div v-for="(s, sind) in seats"
                     :class="[{
                    hasTicket: s.ticket && s.ticket.price,
                    selected: selectedSeats.includes(s.id),
                    dragHovered: selectedIndexesByDragging.includes(sind),
                    sold: s.ticket && s.ticket.sold,
                    blocked: s.ticket && s.ticket.blocked,
                 }, s.ticket ? 'color-'+prices.indexOf(s.ticket.price) : '']"
                     @click="$emit('seatPressed', s)"
                     ref="seat"
                     :id="'seat-'+sind"
                     class="seat"
                     :key="'seat-'+sind"
                     :style="`left: ${s.x}px; top: ${s.y}px;`"
                >{{ s.seat }}
                </div>
                <div class="seat-row"
                     @click="$emit('rowPressed', r)"
                     v-for="r in Object.keys(rows)"
                     :key="'row-'+r"
                     :style="`top: ${rows[r].y}px`">
                    Ряд {{ r }}
                </div>
            </div>
        </div>
    </div>
</template>

<script>

    import ZoomBlock from "../../../app/components/ZoomBlock"
    const POINT_MODEL = ['offsetX', 'offsetY', 'clientX', 'clientY'];

    const throttle = (method, delay = 30) => {
        let timer = null;
        return function() {
            if (timer) return;
            const args = arguments;
            timer = setTimeout(() => {
                method.apply(this, args);
                timer = null;
            }, delay);
        };
    }

    export default {
        components: { ZoomBlock },
        props: {
            mouseSelectable: {
                type: Boolean,
                default: false,
            },
            seats: {
                type: Array,
                required: true
            },
            selectedSeats: {
                type: Array,
                default: []
            },
            prices: {
                type: Array,
                default() {
                    return []
                },
            }
        },
        watch: {
            seats(val) {
                this.checkRows()
            },
            dragging(val) {
                if (val) {
                    this.collectDOMPoints();
                    this.initBrowserPoint();
                }
            }
        },
        methods: {
            checkRows() {
                this.rows = {}
                this.maxW = 0
                this.seats.forEach(item => {
                    this.maxW = Math.max(this.maxW, (item.x + 50))
                    if(!this.rows.hasOwnProperty(item.row)) {
                        this.$set(this.rows, item.row, { y: item.y })
                    }
                })
                let rows_array = (Object.keys(this.rows))
                this.$emit('maxRow',(rows_array.length > 0 ? Math.max(...rows_array) : 0))
            },
            handleMouseDown(e) {
                if(!this.mouseSelectable) {
                    return
                }
                this.selectedIndexesByDragging = []
                this.$nextTick(() => {
                    this.resetPoint(e);
                    this.updatePointData(this.point, e);
                    window.addEventListener('mouseup', this.handleMouseUp);
                    window.addEventListener('mousemove', this.handleMouseMoveThrottled);
                });
            },
            handleMouseUp(e) {
                this.dragging = false;
                this.updatePointData(this.point, e);
                this.resetPoint(e);
                window.removeEventListener('mouseup', this.handleMouseUp);
                window.removeEventListener('mousemove', this.handleMouseMoveThrottled);
                this.selectedIndexesByDragging.forEach(index => {
                    this.$emit('seatPressed',this.seats[index])
                })
                this.selectedIndexesByDragging = []
            },
            handleMouseMove(e) {
                if (!this.dragging) {
                    this.dragging = true;
                }
                this.updatePointData(this.endPoint, e);
                this.updatePointData(this.point, e);
                this.$nextTick(() => {
                    this.childrenDOMPoints.forEach(child => {
                        const isSelected = this.checkIfChildInSelectArea(child.point);
                        if(isSelected) {
                            this.selectedIndexesByDragging.push(parseInt(child.instance.id.replace('seat-','')))
                            this.selectedIndexesByDragging = [...new Set(this.selectedIndexesByDragging)]
                        }
                    });
                });
            },
            updatePointData(pointObj, pointData) {
                POINT_MODEL.forEach(key => {
                    this.$set(pointObj, key, pointData[key]);
                });
            },
            resetPoint(e) {
                this.updatePointData(this.startPoint, e);
                this.updatePointData(this.endPoint, e);
            },
            initBrowserPoint() {
                this.browserPoint = {
                    clientWidth: document.body.clientWidth,
                    clientHeight: document.body.clientHeight,
                    scrollWidth: document.body.scrollWidth,
                    scrollHeight: document.body.scrollHeight
                };
            },
            checkIfChildInSelectArea(childItem) {
                const startClientX = this.startPoint.clientX;
                const startClientY = this.startPoint.clientY;
                const endClientX = this.endPoint.clientX;
                const endClientY = this.endPoint.clientY;
                const selectPoint = {
                    left: Math.min(startClientX, endClientX),
                    top: Math.min(startClientY, endClientY),
                    width: Math.abs(startClientX - endClientX),
                    height: Math.abs(startClientY - endClientY)
                };
                return selectPoint.left <= childItem.left + childItem.width
                    && selectPoint.left + selectPoint.width >= childItem.left
                    && selectPoint.top <= childItem.top + childItem.height
                    && selectPoint.top + selectPoint.height >= childItem.top;
            },
            collectDOMPoints() {
                let element = this.$refs.vw
                const DOMRect = element.getBoundingClientRect();
                this.selfPoint = {
                    clientX: DOMRect.left || DOMRect.x,
                    clientY: DOMRect.top || DOMRect.y,
                };
                this.childrenDOMPoints = this.childItems.map(child => ({
                    point: child.getBoundingClientRect(),
                    instance: child
                }));
            },
        },
        mounted() {
            this.checkRows()
            this.handleMouseMoveThrottled = throttle(this.handleMouseMove);
            this.childItems = this.$refs.seat
        },
        created() {
        },
        data() {
            return {
                rows: {},
                dragging: false,
                handleMouseMoveThrottled: () => {
                },
                point: {
                    offsetX: 0,
                    offsetY: 0
                },
                startPoint: {
                    offsetX: 0,
                    offsetY: 0
                },
                endPoint: {
                    offsetX: 0,
                    offsetY: 0
                },
                selfPoint: {
                    clientX: 0,
                    clientY: 0
                },
                scale: 1,
                maxW: 0,
                childItems: [],
                childrenDOMPoints: [],
                selectedIndexesByDragging: [],
                browserPoint: {
                },
            }
        },
        computed: {
            selectAreaStyle() {
                const startClientX = this.startPoint.clientX - this.selfPoint.clientX;
                const endClientX = this.endPoint.clientX - this.selfPoint.clientX;
                const startClientY = this.startPoint.clientY - this.selfPoint.clientY;
                const endClientY = this.endPoint.clientY - this.selfPoint.clientY;
                const { left, top, width, height } = {
                    left: Math.min(startClientX, endClientX),
                    top: Math.min(startClientY, endClientY),
                    width: Math.abs(startClientX - endClientX),
                    height: Math.abs(startClientY - endClientY)
                };
                // console.log(`width = ${width}px, height = ${height}px, left = ${left}px, top = ${top}px`);
                return {
                    left: `${left}px`,
                    top: `${top}px`,
                    width: `${width}px`,
                    height: `${height}px`,
                    zIndex: 444,
                    backgroundColor: 'rgba(51, 51, 51, 0.5)',
                    position: 'absolute'
                };
            }
        },
        name: "SectionScheme"
    }
</script>

<style scoped>

</style>