require('./bootstrap');
require('./translations');
require('./filters');
require('./window');

import store from './store'

const files = require.context('./vue/app/components', true, /\.vue$/i);
files.keys().map(key =>
    Vue.component(key.split('/').pop().split('.')[0], files(key).default)
);

import VueMeta from 'vue-meta'
Vue.use(VueMeta)

import VueRouter from 'vue-router'
Vue.use(VueRouter)

import WidgetInit from './vue/app/components/new_widget/WidgetInit'
import Event from './vue/app/components/new_widget/Event'
import Timetable from './vue/app/components/new_widget/Timetable'
import Checkout from './vue/app/components/Checkout'
import SuccessStatus from './vue/app/components/SuccessStatus'

const routes = [
    // { path: '/', redirect: '/dashboard' },
    { path: '/', name: 'widgetinit', component: WidgetInit },
    { path: '/:eventid', name: 'event', component: Event },
    { path: '/:eventid/:timetableid', name: 'timetable', component: Timetable },
    { path: '/order/:id/:hash', name: 'checkout', component: Checkout },
    { path: '/result/success', name: 'successstatus', component: SuccessStatus },
]

const router = new VueRouter({
    // mode: 'history',
    routes,
    scrollBehavior (to, from, savedPosition) {
        return { x: 0, y: 0 }
    }
});

router.beforeEach((to, from, next) => {
    next()
})

const load = () => {
    new Vue({
        el: '#vue-new-widget',
        router,
        store,
    });
}

store.dispatch('getSettings').then(() => {
    load()
})