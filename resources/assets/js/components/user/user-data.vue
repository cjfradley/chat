<template>
    <div v-if="user" class="p-4 mb-4 flex justify-between items-center bg-indigo-700 font-bold">
        {{ user.username }}
        <Zondicon
            icon="User"
            class="fill-current text-gray-600 h-6 w-6 bg-gray-400 p-1 rounded-full"
        />
    </div>
</template>

<script>
    import { mapActions, mapGetters } from 'vuex'
    import Zondicon from 'vue-zondicons'

    export default {
        components: {
            Zondicon
        },
        mounted () {
            this.getUser()
            .then((response) => {
                this.getChats()
            })
            this.getUsers()
        },
        computed: {
            ...mapGetters({
                user: 'user/user'
            })
        },
        methods: {
            ...mapActions({
                getUser: 'user/getUser',
                getUsers: 'user/getUsers',
                getChats: 'chat/getChats'
            })
        }
    }
</script>