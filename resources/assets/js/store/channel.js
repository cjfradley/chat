import axios from 'axios'

export default {
    namespaced: true,

    state: {
        channels: []
    },

    getters: {
        channels(state) {
            return state.channels
        }
    },

    mutations: {
        SET_CHANNELS(state, data) {
            state.channels = data
        }
    },

    actions: {
        async getChannels({ commit }) {
            try {
                const response = await axios.get('/api/chats/channels')
                commit('SET_CHANNELS', response.data.data)
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