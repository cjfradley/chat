// require in bootstrap file
require('./bootstrap')

// attach vue to window
window.Vue = require('vue')

// add vuex
import Vuex from 'vuex'
Vue.use(Vuex)

// adding vSelect
import vSelect from 'vue-select'
Vue.component('v-select', vSelect)

// adding moment as global
Vue.use(require('vue-moment'))

// add global modal component
import VModal from 'vue-js-modal'
Vue.use(VModal, { dynamic: true, injectModalsContainer: true })

// automatically adding all vue files to app
const files = require.context('./', true, /\.vue$/i)
files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

// add vuex store
import chat from './store/chat'
import user from './store/user'
import channel from './store/channel'
const store = new Vuex.Store({
    modules: {
        chat,
        user,
        channel
    }
})


// creating new vue instance
var app = new Vue({
    el : '#app',
    store
});

window.app = app
