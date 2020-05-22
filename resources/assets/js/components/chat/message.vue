<template>
    <div
        :class="{ 'justify-end': isUsersMessage }"
        class="flex"
    >
        <div
            :class="{ 'bg-gray-400': isUsersMessage }"
            class="p-2 bg-gray-200 rounded-md inline-block max-w-sm break-words"
        >
            {{ message.body }}
        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex'
    export default {
        props: {
            message: {
                required: true,
                type: Object
            }
        },
        computed: {
            ...mapGetters({
                user: 'user/user'
            }),
            isUsersMessage () {
                return this.user.id === this.message.user.data.id
            }
        }
    }
</script>