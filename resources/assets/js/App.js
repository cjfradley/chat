// require in bootstrap file
require('./bootstrap')

// attach vue to window
window.Vue = require('vue')

// add vuex
import Vuex from 'vuex'
Vue.use(Vuex)

// automatically adding all vue files to app
const files = require.context('./', true, /\.vue$/i)
files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

// add vuex store
import chat from './store/chat'
const store = new Vuex.Store({
    modules: {
        chat
    }
})


// creating new vue instance
const app = new Vue({
    el : '#app',
    store
});
