<template>
  <div class="pt-5 pb-5 bg-blue-900 text-gray-300 w-full h-full">
    
    <user-data></user-data>
    
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
    import userData from './../user/user-data'

    export default {
        components: {
            chatListItem,
            userData
        },
        computed: {
            ...mapGetters({
                chats: 'chat/chats'
            })
        }
    }
</script>