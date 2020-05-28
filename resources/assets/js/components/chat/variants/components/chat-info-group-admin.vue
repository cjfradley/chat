<template>
    <div class="w-full">
         <input
            v-model="chat.title"
            class="mb-3 w-full py-2 px-4 rounded-lg block appearance-none leading-normal outline-none focus:shadow-outline focus:bg-blue-100 text-gray-700"
            type="text"
            placeholder="chat title"
        >
        <div class="flex justify-between items-center w-full">
            <v-select
                :options="availableUsers"
                @input="addUser"
                v-model="userToAdd"
                label="username"
                placeholder="add user"
            ></v-select>
            <div class="flex items-center">
                <div
                    v-for="u in chat.users.data"
                    :key=u.id
                    class="flex items-center pl-3 text-sm font-bold text-gray-700 bg-gray-400 rounded-lg ml-3"
                >
                    <span class="mr-2">
                        {{ u.username }}
                    </span>
                    <div
                        v-if="u.id !== user.id"
                        @click="removeUser(u.id)"
                        class="p-2 hover:bg-gray-500 rounded-tr-lg rounded-br-lg"
                    >
                        <Zondicon
                            icon="Close"
                            class="fill-current text-red-800 h-3 w-3"
                        />
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import { mapGetters, mapActions } from 'vuex'
    import Zondicon from 'vue-zondicons'

    export default {
        data () {
            return {
                userToAdd: null
            }
        },
        components: {
            Zondicon
        },
        computed: {
            ...mapGetters({
                user: 'user/user',
                users: 'user/users',
                chat: 'chat/activeChat'
            }),
            availableUsers () {
                return this.users.filter(e => !this.chat.users.data.find(u => u.id === e.id))
            }
        },
        methods: {
            ...mapActions({
                getChats: 'chat/getChats'
            }),
            async addUser () {
                const response = await axios.post(`api/chats/${this.chat.id}/add-user`, {
                    userId: this.userToAdd.id
                })
                this.getChats()
                this.userToAdd = null
            },
            async removeUser (userId) {
                const response = await axios.post(`api/chats/${this.chat.id}/remove-user`, {
                    userId
                })
                this.getChats()
            }
        }
    }
</script>