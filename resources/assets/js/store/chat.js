import axios from 'axios'
import { omit as _omit, cloneDeep as _clone } from "lodash"

export default {
    namespaced: true,

    state: {
        chats: [],
        newMessages: [],
        activeChat: null
    },

    getters: {
        chats (state) {
            return state.chats
        },
        activeChat (state) {
            return state.activeChat
        },
        newMessages (state) {
            return state.newMessages
        }
    },

    mutations: {
        PUSH_CHATS (state, data) {
            state.chats = data
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
        },
        ADD_NEW_MESSAGES_COUNT (state, { chatId, count }) {
            if (!count) {
                state.newMessages = state.newMessages.filter(e => e.chatId !== chatId)
                return
            }
            const m = state.newMessages.find(e => e.chatId === chatId)
            if (m) {
                m.count = (m.count + count)
                return
            }
            state.newMessages.push({ chatId, count })
            
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
        addMessageToSpecificChat ({ commit, dispatch, rootState }, message) {
            const newMessage = _omit(_clone(message.data.data), 'chat')
            const chatId = message.data.data.chat.data.id
            if (newMessage.user.data.id !== rootState.user.user.id) {
                commit('PUSH_MESSAGE_TO_CHAT', {newMessage, chatId})
                dispatch('addNewMessage', { chatId, count: 1 })
            }
            return
        },
        addNewMessage ({ state, commit }, payload) {
            if (state.activeChat.id !== payload.chatId) {
                const chatId = payload.chatId
                const count = payload.count
                commit('ADD_NEW_MESSAGES_COUNT', { chatId, count })
            }
        }
    }
}