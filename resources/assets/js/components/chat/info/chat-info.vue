<template>
    <div class="flex p-4 bg-gray-200 rounded-lg">

        <div class="w-full" v-if="user.id === chat.adminId">
            <component :is="`chat-info-admin-${chat.type}`"></component>
        </div>
        
        <div v-else class="flex w-full items-center justify-between">
            <h1
                class="text-gray-700 font-bold font-md"
            >
                {{ chat.title }}
            </h1>
            <chat-info-users></chat-info-users>
        </div>

    </div>
</template>

<script>
    import { mapGetters } from 'vuex'

    export default {
        computed: {
            ...mapGetters({
                user: 'user/user',
                chat: 'chat/activeChat'
            })
        }
    }
</script>