<template>
    <div class="w-full">
         <input
            v-model="chat.title"
            class="mb-3 w-full py-2 px-4 rounded-lg block appearance-none leading-normal outline-none focus:shadow-outline focus:bg-blue-100 text-gray-700"
            type="text"
            placeholder="chat title"
        >
        <div class="w-full md:w-1/4">
            <v-select
                :options="availableUsers"
                @input="addUser"
                v-model="userToAdd"
                label="username"
                placeholder="add user"
            ></v-select>

            {{ availableUsers }}
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import { mapGetters, mapActions } from 'vuex'

    export default {
        data () {
            return {
                userToAdd: null
            }
        },
        computed: {
            ...mapGetters({
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
            }
        }
    }
</script>