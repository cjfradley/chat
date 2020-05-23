<template>
    <div class="flex p-4 bg-gray-200 rounded-lg">

        <div class="w-full" v-if="user.id === chat.adminId">
            <chat-info-group-admin></chat-info-group-admin>
        </div>
        
        <div v-else>
            <h1
                class="text-gray-700 font-bold font-md"
            >
                {{ chat.title }}
            </h1>
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