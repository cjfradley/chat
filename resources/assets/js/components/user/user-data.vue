<template>
    <div v-if="user">
        {{ user.username }}
    </div>
</template>

<script>
    import { mapActions, mapGetters } from 'vuex'

    export default {
        mounted () {
            this.getUser()
            .then(() => {
                this.getChats()
            })
        },
        computed: {
            ...mapGetters({
                user: 'user/user'
            })
        },
        methods: {
            ...mapActions({
                getUser: 'user/getUser',
                getChats: 'chat/getChats'
            })
        }
    }
</script>