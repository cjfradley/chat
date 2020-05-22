<template>
    <div
        :class="{ 'bg-blue-700' : isActive }"
        @click.prevent="showChat"
        class="pt-2 pb-2 pl-5 pr-5 hover:bg-blue-700 cursor-default"
    >
        {{ title }}
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
                user: 'user/user'
            }),
            title () {
                const usersOtherThanMe = this.chat.users.data.filter(e => e.id !== this.user.id)
                return usersOtherThanMe[0].username
            },
            isActive () {
                return this.activeChat ? this.activeChat.id === this.chat.id : false
            }
        },
        methods: {
            ...mapActions({
                setActiveChat: 'chat/setActiveChat'
            }),
            showChat () {
                this.setActiveChat(this.chat)
            }
        }
    }
</script>