<template>
    <div class="flex items-center">
        <div
            v-for="(u, number) in chat.users.data"
            :key=u.id
            :class="{ 'ml-3': number > 0 }"
            class="flex items-center pl-3 text-sm font-bold text-gray-700 bg-gray-400 rounded-lg"
        >
            <span class="mr-2">
                {{ u.username }}
            </span>
            <div
                v-if="u.id !== user.id && user.id === chat.adminId"
                @click="removeUser(u.id)"
                class="p-2 hover:bg-gray-500 rounded-tr-lg rounded-br-lg"
            >
                <Zondicon
                    icon="Close"
                    class="fill-current text-red-800 h-3 w-3"
                />
            </div>
            <div
                v-else
                class="p-2 bg-gray-400 rounded-tr-lg rounded-br-lg"
            >
                <Zondicon
                    icon="User"
                    class="fill-current text-gray-600 h-3 w-3"
                />
            </div>
        </div>
    </div>
</template>

<script>
    import { mapGetters, mapActions } from 'vuex'
    import Zondicon from 'vue-zondicons'

    export default {
        components: {
            Zondicon
        },
        computed: {
            ...mapGetters({
                user: 'user/user',
                chat: 'chat/activeChat'
            })
        },
        methods: {
            ...mapActions({
                getChats: 'chat/getChats'
            }),
            async removeUser (userId) {
                const response = await axios.post(`api/chats/${this.chat.id}/remove-user`, {
                    userId
                })
                this.getChats()
            }
        }
    }
</script>