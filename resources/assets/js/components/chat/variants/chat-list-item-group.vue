<template>
    <div
        :class="[ isActive ? 'bg-blue-700' : 'hover:bg-blue-800' ]"
        @click.prevent="showChat"
        class="flex pt-2 pb-2 pl-5 pr-5 cursor-default items-center justify-between"
    >
        <div>
            {{ chat.title }}
        </div>
        <div v-if="hasNewMessages" class="w-5 h-5 rounded-full bg-orange-700 flex items-center justify-center">
            <span class="font-bold text-sm">{{ hasNewMessages }}</span>
        </div>

    </div>
</template>

<script>
    import { mapGetters, mapActions } from "vuex";

    export default {
        props: {
            chat: {
                required: true,
                type: Object
            }
        },
        computed: {
            ...mapGetters({
                activeChat: 'chat/activeChat',
                newMessages: 'chat/newMessages',
                user: 'user/user'
            }),
            title () {
                const usersOtherThanMe = this.chat.users.data.filter(e => e.id !== this.user.id)
                return usersOtherThanMe[0].username
            },
            isActive () {
                return this.activeChat ? this.activeChat.id === this.chat.id : false
            },
            hasNewMessages () {
                const found = this.newMessages.find(e => e.chatId === this.chat.id)
                return found ? found.count : 0
            }
        },
        methods: {
            ...mapActions({
                setActiveChat: 'chat/setActiveChat',
                addNewMessage: 'chat/addNewMessage'
            }),
            showChat () {
                this.setActiveChat(this.chat)
                this.addNewMessage({ chatId: this.chat.id, count: 0 })
            }
        }
    }
</script>