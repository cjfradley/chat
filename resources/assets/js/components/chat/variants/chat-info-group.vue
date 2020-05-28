<template>
    <div class="flex p-4 bg-gray-200 rounded-lg">

        <div class="w-full" v-if="user.id === chat.adminId">
            <chat-info-group-admin></chat-info-group-admin>
        </div>
        
        <div class="flex w-full items-center justify-between" v-else>
            <h1
                class="text-gray-700 font-bold font-md"
            >
                {{ chat.title }}
            </h1>
            <chat-info-users :chat="chat"></chat-info-users>
        </div>

    </div>
</template>

<script>
    import { mapGetters } from 'vuex'

    import chatInfoUsers from "./components/chat-info-users";

    export default {
        components: {
            chatInfoUsers
        },
        computed: {
            ...mapGetters({
                user: 'user/user',
                chat: 'chat/activeChat'
            })
        }
    }
</script>