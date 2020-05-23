<template>
  <div class="pt-5 pb-5 bg-blue-900 text-gray-300 w-full h-full">
    
    <div class="mb-3">
        <user-data></user-data>
    </div>
    
    <!--- private chats --->
    <div class="px-4 py-2 text-gray-500">
        private chats
    </div>
    <div class="mb-3">
        <chat-list-item
            v-for="chat in filteredBy('private', 'id')"
            :key="chat.id"
            :chat="chat"
        ></chat-list-item>
    </div>

    <!--- group chats --->
    <div class="px-4 py-2 text-gray-500">
        group chats
    </div>

    <div class="px-4">
        <add-chat type="group"></add-chat>
    </div>

    <div class="mb-3">
        <chat-list-item
            v-for="chat in filteredBy('group', 'title')"
            :key="chat.id"
            :chat="chat"
        ></chat-list-item>
    </div>

    <!--- channels chats --->
    <div class="px-4 py-2 text-gray-500">
        channels
    </div>

    <div class="px-4">
        <add-chat type="channel"></add-chat>
    </div>

    <div>
        <chat-list-item
            v-for="chat in filteredBy('channel', 'title')"
            :key="chat.id"
            :chat="chat"
        ></chat-list-item>
    </div>

  </div>
</template>

<script>
    import { mapGetters, mapActions } from "vuex"
    import chatListItem from './chat-list-item'
    import addChat from './add-chat'
    import userData from './../user/user-data'

    export default {
        components: {
            chatListItem,
            userData,
            addChat
        },
        computed: {
            ...mapGetters({
                chats: 'chat/chats'
            })
        },
        methods: {
            ...mapActions({
                getChats: 'chat/getChats'
            }),
            filteredBy (type, sortBy) {
                return this.chats.filter(e => e.type === type).sort((a, b) => b[sortBy] - a[sortBy])
            },
            handleMessageFromSocket (message) {
                if (message.data === 'new') {
                    this.getChats()
                }
            }
        }
    }
</script>