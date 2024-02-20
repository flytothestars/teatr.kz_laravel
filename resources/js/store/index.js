import Vue from 'vue'
import Vuex from 'vuex'
import { tickets_limit } from './../config'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    venue: null,
    scheme: null,
    event: null,
    timetable: null,
    order: null,
    seats: [],
    tickets: [],
    pricegroups: {},
    prices: {},
    step: 1,
    checkouttime: 0,
    cart: [],
    user: null,
    settings: null,
  },
  getters:{
    getCartSum(state) {
      return state.cart.reduce((a, o) => (a = a + o.price, a), 0)
    },
},
  mutations: {
    setVenue(state, venue) {
      state.venue = venue
    },
    setScheme(state, scheme) {
      state.scheme = scheme
    },
    setEvent(state, event) {
      state.event = event
    },
    setTimetable(state, timetable) {
      state.timetable = timetable
    },
    setSeats(state, seats) {
      state.seats = seats
    },
    setPrices(state, prices) {
      state.prices = prices
    },
    setTickets(state, tickets) {
      state.tickets = tickets
    },
    setPricegroups(state, pricegroups) {
      state.pricegroups = pricegroups
    },
    setOrder(state, order) {
      state.order = order
    },
    setUser(state, user) {
      state.user = user
    },
    setSettings(state, settings) {
      state.settings = settings
    },
    setCheckoutTime(state, time) {
      state.checkouttime = time
    },
    setStep(state, step) {
      state.step = step
      // if(step === 1) {
      //   state.venue = null
      //   state.event = null
      //   state.timetable = null
      //   state.order = null
      //   state.seats = []
      //   state.tickets = []
      //   state.cart = []
      // }
    },
    updateCart(state, { sign, ticket }) {
      if(sign === '+' && state.cart.length < tickets_limit) {
        state.cart.push(ticket)
      }
      if(sign === '-') {
        const conditions = ['seat_id','section_id','pricegroup_id']
        let removed = false
        state.cart.forEach((item, index) => {
          if(!removed) {
            let found_prop = false
            conditions.forEach(cond => {
              if(ticket[cond] && !removed && !found_prop) {
                found_prop = true
                if(item[cond] == ticket[cond]) {
                  removed = true
                  state.cart.splice(index, 1)
                }
              }
            })
          }
        })
      }
    },
    emptyCart(state) {
      state.cart = []
    }
  },
  actions: {
    generateOrder({commit, state}) {
      window.loaderIcon()
      return new Promise((resolve, reject) => {
        axios.post('/api/order/init', {
          cart: state.cart,
          timetable_id: state.timetable.id
        }).then(res => {
          window.loaderIcon(false)
          if(res.data.error) {
            window.noty(res.data.error, 'error')
            resolve(res.data.order)
            return
          }
          commit('setOrder', res.data.order)
          commit('setUser', res.data.user)
          resolve(res.data.order)
        }).catch((err) => {
          window.loaderIcon(false)
          reject(err)
        })
      })
    },
    getSettings({commit, state}) {
      window.loaderIcon()
      return new Promise((resolve, reject) => {
        axios.get('/api/settings').then(res => {
          commit('setSettings', res.data.settings)
          commit('setUser', res.data.user)
          resolve(res.data)
        }).catch((err) => {
          reject(err)
        })
      })
    }
  },
  modules: {
  }
})
