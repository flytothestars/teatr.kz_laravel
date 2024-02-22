<template>
    <div>
        <div class="d-md-none d-block bg-themed">
            <div class="row">
                <div class="col">
                    <i @click="collapsed = !collapsed"
                       class="menu-collapser text-white d-md-none d-inline-block p-3 ti-menu"></i>
                </div>
            </div>
        </div>
        <div class="shadow" @click="collapsed = !collapsed" :class="{collapsed: collapsed }"></div>
        <div class="sidebar"
             :class="{collapsed: collapsed}"
             data-background-color="white"
             data-color="white"
             data-active-color="danger">
            <div class="sidebar-wrapper">
                <div class="border-bottom " @click="collapsed = !collapsed">
                    <div class="logo text-center align-items-center d-flex start">
                        <a class="font-weight-bold w-100 py-3 col text-center d-block" href="/admin#/dashboard">
                            <img class="admin-logo" src="/images/logo_w.svg" alt="logo"/>
                        </a>
                        <span class="d-md-none d-inline-block position-absolute" style="right:20px;">
                            <i class="ti ti-close"></i>
                        </span>
                    </div>
                </div>

                <ul class="pt-4 pl-4">
                    <li class="d-block" v-for="(m,ind) in menu" v-if="!m.permission || permissions.includes(m.permission)">
                        <template v-if="m.children">
                            <a class="menu-item" data-toggle="collapse"
                               :href="'#collapse'+ind"
                               aria-expanded="false"
                               :aria-controls="'collapse'+ind">
                                <i class="d-inline-block menu-icon"
                                   :style="{ mcolor: m.color }"
                                   :class="m.icon"></i>{{ m.title }} <span class="dropdown-arrow d-inline-block">
                                <i class="ti-angle-right"></i>
                            </span>
                            </a>
                            <ul v-if="m.children" class="collapse" :id="'collapse'+ind">
                                <li v-for="ch in m.children" class="d-block"  v-if="!ch.permission || permissions.includes(ch.permission)">
                                    <router-link class="menu-item pl-4" :to="{name: ch.name, params: ch.params}">
                                        {{ ch.title }}
                                    </router-link>
                                </li>
                            </ul>
                        </template>
                        <template v-else>
                            <router-link class="menu-item" :to="{name: m.name, params: m.params}">
                                <i class="d-inline-block menu-icon"
                                   :style="{ mcolor: m.color }"
                                   :class="m.icon"></i>{{ m.title }}
                            </router-link>
                        </template>
                    </li>
                </ul>

                <div class="position-fixed bg-white b-0 bottom-logout">
                    <hr>
                    <div class="pl-4">
                        <div class="row align-items-center no-gutters">
                            <div class="text-muted col-auto f-13">Admin, </div>
                            <div class="col-auto">
                                <form action="/logout" class="f-0" method="post">
                                    <div v-html="window.csrf_field()"></div>
                                    <input type="submit" id="logout-submit" class="text-underlined pl-0 py-0 btn-link btn ml-2" value="Выйти">
                                </form>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</template>

<script>
    export default {
        mounted() {
            this.getMyPermissions()
        },
        methods: {
            makeActive(url) {
                this.activeUrl = url
            },
            getMyPermissions() {
                axios.get('/admin/mypermissions').then(res => {
                    this.permissions = res.data
                })
            }
        },
        watch: {
            $route() {
                this.collapsed = true
            }
        },
        data: function() {
            return {
                collapsed: ($(window).width() < 768),
                permissions: [],
                menu: [
                    { name: 'qr_scan', permission: "casher_panel", title: 'QR', color: "#aaa", icon: 'ti-bar-chart' },
                    { name: 'dashboard', permission: "admin_panel", title: 'Главная', color: "#aaa", icon: 'ti-bar-chart'},
                    { permission: "admin_panel", title: 'Места', color: "#aaa", icon: 'ti-world', children: [
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'city' }, title: 'Города', color: "#aaa", icon: 'ti-world'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'venue' }, title: 'Площадки', color: "#aaa", icon: 'ti-pin-alt'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'venue_scheme' }, title: 'Рассадки', color: "#aaa", icon: 'ti-pin-alt'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'section' }, title: 'Сектора', color: "#aaa", icon: 'ti-view-grid'},
                        ]
                    },
                    { name: 'eloquent_list', permission: "admin_panel", params: { model: 'event' }, title: 'События', color: "#aaa", icon: 'ti-microphone'},
                    { name: 'eloquent_list', permission: "admin_panel", params: { model: 'timetable' }, title: 'Сеансы', color: "#aaa", icon: 'ti-calendar'},
                    { name: 'eloquent_list', permission: "admin_panel", params: { model: 'menu_item' }, title: 'Пункты меню', color: "#aaa", icon: 'ti-menu'},
                    {
                        permission: "admin_panel", title: 'Продажи', color: "#aaa", icon: 'ti-shopping-cart', children: [
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'order' }, title: 'Заказы', color: "#aaa", icon: 'ti-shopping-cart'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'deleted_order' }, title: 'Удаленные заказы', color: "#aaa", icon: 'ti-shopping-cart'},
                            { name: 'report', permission: "admin_panel", title: 'Отчеты', color: "#aaa", icon: 'ti-cloud-down'},
                        ]
                    },
                    { permission: "admin_panel", title: 'Контент', color: "#aaa", icon: 'ti-book', children: [
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'news' }, title: 'Новости', color: "#aaa", icon: 'ti-alert'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'feedback' }, title: 'Рецензии', color: "#aaa", icon: 'ti-alert'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'cast' }, title: 'Артисты', color: "#aaa", icon: 'ti-alert'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'partner' }, title: 'Партнеры', color: "#aaa", icon: 'ti-alert'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'page' }, title: 'Страницы', color: "#aaa", icon: 'ti-book'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'meta' }, title: 'Мета', color: "#aaa", icon: 'ti-book'},
                        ]
                    },

                    { name: 'eloquent_list', permission: "admin_panel", params: { model: 'user' }, title: 'Пользователи', color: "#aaa", icon: 'ti-face-smile'},
                    { name: 'eloquent_list', permission: "admin_panel", params: { model: 'category' }, title: 'Категории', color: "#aaa", icon: 'ti-server'},
                    { name: 'eloquent_list', permission: "admin_panel", params: { model: 'ticket_design' }, title: 'Шаблоны', color: "#aaa", icon: 'ti-ticket'},
                    { title: 'Настройки', permission: "admin_panel", icon: 'ti-settings', color: "#aaa", name: 'eloquent_list', params: { model: 'setting' }, children: [
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'setting' }, title: 'Настройки'},
                            { name: 'eloquent_list', permission: "admin_panel", params: { model: 'activity_log' }, title: 'Логи'},
                        ]
                    },
                    // { title: 'Настройки', icon: 'ti-settings', color: "#aaa", children: [
                    //         { name: 'eloquent_list', params: { model: 'setting' }, title: 'Настройки'},
                    //     ]
                    // },
                ],
                activeUrl: '',
            }
        }
    }
</script>

<style scoped>
    .dropdown-arrow {
        font-size: 11px;
        float: right;
        margin-right: 20px;
    }

    a[aria-expanded=true] .dropdown-arrow {
        -webkit-transform: rotate(90deg);
        -moz-transform: rotate(90deg);
        -ms-transform: rotate(90deg);
        -o-transform: rotate(90deg);
        transform: rotate(90deg);
    }
    .admin-logo {
        max-width: 130px;
        max-height: 60px;
    }
    div.logo {
        background-color: #3a374c;
    }
</style>
