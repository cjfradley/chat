import axios from 'axios'

export default {
    namespaced: true,

    state: {
        chats: [],
        activeChat: null
    },

    getters: {
        chats (state) {
            return state.chats
        },
        activeChat (state) {
            return state.activeChat
        }
    },

    mutations: {
        PUSH_CHATS (state, data) {
            state.chats.push(...data)
        },
        SET_ACTIVE_CHAT (state, data) {
            state.activeChat = data
        }
    },

    actions: {
        async getChats ({ commit, state, dispatch }) {
            let response = await axios.get('/api/users/2/chats')
            commit('PUSH_CHATS', response.data.data)

            if (!state.activeChat && response.data.data.length) {
                dispatch('setActiveChat', response.data.data[0])
            }
        },
        setActiveChat ({ commit }, chat) {
            commit('SET_ACTIVE_CHAT', chat)
        }
    }
}