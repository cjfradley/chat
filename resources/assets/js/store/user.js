import axios from 'axios'

export default {
    namespaced: true,

    state: {
        user: null
    },

    getters: {
        user (state) {
            return state.user
        }
    },

    mutations: {
        SET_USER (state, data) {
            state.user = data
        }
    },

    actions: {
        async getUser ({ commit }) {
            try {
                const response = await axios.get('/api/auth/user')
                commit('SET_USER', response.data.data)
                return response
            } catch (error) {
                if (error.response) {
                    console.log(error.response.data);
                    console.log(error.response.status);
                    console.log(error.response.headers);
                } else if (error.request) {
                    console.log(error.request);
                } else {
                    console.log(error.message);
                }
                console.log(error)
                return error
            }
        }
    }
}