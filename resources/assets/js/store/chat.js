import axios from 'axios'
import { mapGetters } from 'vuex'

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
        },
        PUSH_MESSAGE (state, data) {
            state.activeChat.messages.data.unshift(data)
        }
    },

    actions: {
        async getChats ({ commit, state, dispatch, rootState }) {
            let response = await axios.get(`/api/users/${rootState.user.user.id}/chats`)
            commit('PUSH_CHATS', response.data.data)

            if (!state.activeChat && response.data.data.length) {
                dispatch('setActiveChat', response.data.data[0])
            }
        },
        setActiveChat ({ commit }, chat) {
            commit('SET_ACTIVE_CHAT', chat)
        },
        addMessageToChat ({ commit }, message) {
            commit('PUSH_MESSAGE', message)
        }
    }
}