<template>
    <div class="w-full">
        <div class="mb-3">
            <input
                @input="handleTitleInput"
                v-model="chat.title"
                :class="{ 'border-red-700' : errors.title }"
                class="w-full py-2 px-4 rounded-lg block appearance-none leading-normal outline-none focus:shadow-outline focus:bg-blue-100 text-gray-700"
                type="text"
                placeholder="chat title"
            >
            <small v-if="errors.title" class="text-red-700 ml-1">{{ errors.title[0].MESSAGE }}</small>
        </div>
        <div class="w-full">
            <chat-info-users></chat-info-users>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    import { debounce as _debounce } from "lodash";
    import { mapGetters, mapActions } from 'vuex'

    export default {
        data () {
            return {
                userToAdd: null,
                errors: {}
            }
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
            handleTitleInput () {
                this.errors = {}
                this.editTitle()
            },
            editTitle: _debounce(async function () {
                if (this.chat.title) {
                    try {
                        const response = await axios.patch(`api/chats/${this.chat.id}`, {
                            title: this.chat.title
                        })
                        this.getChats()
                    } catch (error) {
                        this.errors = error.response.data
                    }
                }
            }, 700)
        }
    }
</script>