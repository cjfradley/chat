<template>
  <div class="pt-5 pb-5 bg-blue-900 text-gray-300 w-full h-full">
    
    <div class="mb-3">
        <transition name="fade">
            <user-data></user-data>
        </transition>
    </div>
    
    <transition name="fade" mode="out-in">

        <div key="one" v-if="loading" class="flex justify-center items-center">
            <div class="loader loader ease-linear rounded-full border-4 border-t-4 border-gray-400 h-10 w-10"></div>
        </div>

        <div key="two" v-else>
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
        
    </transition>

  </div>
</template>

<script>
    import { mapGetters, mapActions } from 'vuex'

    export default {
        data () {
            return {
                loading: true
            }
        },
        computed: {
            ...mapGetters({
                chats: 'chat/chats',
                user: 'user/user'
            })
        },
        watch: {
            user: function (e) {
                if (e.id) {
                    this.getChats().then(() => this.loading = false)
                }
            }
        },
        methods: {
            ...mapActions({
                getChats: 'chat/getChats',
                getUsers: 'user/getUser'
            }),
            filteredBy (type, sortBy) {
                return this.chats.filter(e => e.type === type).sort((a, b) => b[sortBy] - a[sortBy])
            },
            handleMessageFromSocket (message) {
                if (message.data === 'new') {
                    this.getChats()
                    this.getUsers()
                }
            }
        }
    }
</script>