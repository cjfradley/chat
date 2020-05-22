import axios from 'axios'
import { omit as _omit, cloneDeep as _clone } from "lodash"

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
        },
        PUSH_MESSAGE_TO_CHAT (state, {newMessage, chatId}) {
            const chat = state.chats.find(e => e.id === chatId)
            if (chat) {
                chat.messages.data.unshift(newMessage)
            }
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
        },
        addMessageToSpecificChat ({ commit, rootState }, message) {
            const newMessage = _omit(_clone(message.data.data), 'chat')
            const chatId = message.data.data.chat.data.id
            if (newMessage.user.data.id !== rootState.user.user.id) {
                commit('PUSH_MESSAGE_TO_CHAT', {newMessage, chatId})
            }
        }
    }
}