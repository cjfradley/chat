<template>
  <div class="pt-5 pb-5 bg-blue-900 text-gray-300 w-full h-full">
    <chat-list-item
        v-for="chat in chats"
        :key="chat.id"
        :chat="chat"
    ></chat-list-item>
  </div>
</template>

<script>
    import { mapGetters, mapActions } from "vuex"
    import chatListItem from './chat-list-item'

    export default {
        mounted () {
            this.getChats()
        },
        components: {
            chatListItem
        },
        computed: {
            ...mapGetters({
                chats: 'chat/chats'
            })
        },
        methods: {
            ...mapActions({
                getChats: 'chat/getChats'
            })
        }
    }
</script>