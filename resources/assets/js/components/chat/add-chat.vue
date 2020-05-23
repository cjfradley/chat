<template>
    <div class="mb-3">
        <input
            v-model="title"
            @keyup="handleKeyPress"
            class="w-full px-2 py-1 rounded block appearance-none leading-normal bg-blue-800 outline-none focus:shadow-outline"
            type="text"
            :placeholder="`new ${type}`"
        >
    </div>
</template>

<script>
    import axios from "axios"
    import { mapGetters, mapActions } from 'vuex'

    export default {
        props: {
            type: {
                required: true,
                type: String
            }
        },
        data () {
            return {
                title: ''
            }
        },
        computed: {
            ...mapGetters({
                user: 'user/user'
            })
        },
        methods: {
            ...mapActions({
                addChat: 'chat/addChat'
            }),
            handleKeyPress (e) {
                if (e.keyCode === 13) {
                    if (!this.title) {
                        return
                    }
                    this.addChat({
                        title: this.title,
                        type: this.type,
                        admin: this.user.id
                    })
                    .then((response) => {
                        this.title = ''
                    })
                }
            }
        }
    }
</script>