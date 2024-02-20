require('./bootstrap');
require('./translations');
require('./filters');
require('./window');
require('./scripts');
// require('./directives');

if(document.getElementById("vue-app")) {
    new Vue({
        el: '#vue-app',
    });
}

if(document.getElementById("vue-filtered-events")) {

    Vue.directive('select', {
        twoWay: true,
        bind: function (el, binding, vnode) {
            $(el).select2().on("select2:select", (e) => {
                el.dispatchEvent(new Event('change', { target: e.target }));
            });
        },
    });

    new Vue({
        el: '#vue-filtered-events',
        data() {
            return {
                timefilters: [
                    { id: 'today', title: "Сегодня", type: "time" },
                    { id: 'weekend', title: "На выходных", type: "time" },
                    { id: 'month', title: "В этом месяце", type: "time" },
                ],
                events: [],
                venues: [],
                genres: [],
                paginator: null,
                selected: {
                    time: null,
                    venue: null,
                    genre: null
                },
                page: 1
            }
        },
        async created() {
            await this.getFilters()
            this.load(true, false)
        },
        methods: {
            filterClicked(filter) {
                this.$set(this.selected, 'time', filter.id)
            },
            async getFilters() {
                let res = await axios.get('/api/events/filters')
                this.venues = res.data.venues
                this.genres = res.data.genres
            },
            cancelFilters() {
                this.selected = {
                    time: null,
                    venue: null,
                    genre: null
                }
            },
            load(newSearch = false, change = true) {
                window.loaderIcon()
                // axios.get('/api/events', {
                axios.get('/afisha/dynamic', {
                    params: {
                        page:    this.page,
                        filters: { ...this.selected, ...{ city: $('#city-select').val()} }
                    }
                }).then(res => {
                    this.paginator = res.data.events
                    if(newSearch) {
                        this.events = []
                    }
                    this.events.push(...this.paginator.data)
                    if(!change) { return }
                    if(newSearch) {
                        $('#dynamic-afisha').html(res.data.html)
                    } else {
                        $('#dynamic-afisha').append(res.data.html)
                    }
                })
            },
            more() {
                this.page++
                this.load(false)
            }
        },
        watch: {
            selected: {
                deep: true,
                handler() {
                    this.page = 1
                    this.paginator = null
                    this.load(true)
                }
            }
        }
    });
}

if(document.getElementById("vue-subscribe")) {
    new Vue({
        el: '#vue-subscribe',
        data() {
            return {
                email: ''
            }
        },
        methods: {
            submit() {
                window.loaderIcon()
                axios.post('/subscribe', { email: this.email }).then(res => {
                    window.noty(res.data)
                    this.email = ''
                })
            }
        }
    })
}


if(document.getElementById("vue-login")) {
    new Vue({
        el: '#vue-login',
        data() {
            return {
                form: {
                    email: '',
                    password: '',
                    password_confirmation: '',
                },
                error: '',
                loading: false,
                mode: 'login'
            }
        },
        watch: {
            form: {
                 handler() {
                     this.error = ''
                 },
                deep: true
            }
        },
        methods: {
            submit() {
                if(this.loading) {
                    return
                }
                this.loading = true
                window.loaderIcon()
                if(this.mode == 'reset') {
                    axios.post('/password/email', this.form).then(res => {
                        console.log(res.data)
                        this.loading = false
                        this.error = ''
                        window.noty(res.data.message)
                        $('#loginModal').modal('hide')
                        window.loaderIcon(false)
                        // location.reload()
                    }).catch((err) => {
                        console.log(err)
                        this.error = Object.values(err.response.data.errors).join(', ')
                        this.loading = false
                        window.loaderIcon(false)
                    })
                }
                if(this.mode == 'login') {
                    axios.post('/login', this.form).then(res => {
                        console.log(res.data)
                        this.loading = false
                        this.error = ''
                        location.reload()
                    }).catch((err) => {
                        this.error = Object.values(err.response.data.errors).join(', ')
                        this.loading = false
                        window.loaderIcon(false)
                    })
                }
                if(this.mode == 'register') {
                    axios.post('/register', this.form).then(res => {
                        console.log(res.data)
                        this.error = ''
                        this.loading = false
                        location.reload()
                    }).catch((err) => {
                        this.loading = false
                        this.error = Object.values(err.response.data.errors).join(', ')
                        window.loaderIcon(false)
                    })
                }
            }
        }
    })
}



if(document.getElementById("vue-profile")) {
    new Vue({
        el: '#vue-profile',
        data() {
            return {
                user: null,
                loading: false,
            }
        },
        mounted() {
            this.user = JSON.parse($('#user-json').val())
        },
        methods: {
            submit() {
                this.loading = true
                window.loaderIcon()
                axios.post('/profile', this.user).then(res => {
                    window.noty(res.data)
                    this.loading = false
                }).catch(() => {
                    this.loading = false
                })
            }
        }
    })
}
