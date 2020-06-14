<template>
    <div
        :class="{ 'justify-end': isUsersMessage }"
        class="flex"
    >
        <div
            :class="{ 'bg-gray-400': isUsersMessage }"
            class="p-2 bg-gray-200 rounded-md inline-block max-w-sm break-words"
        >
            <div
                v-if="!isUsersMessage && chat.type !== 'private'"
                class="flex justify-between text-sm text-gray-500 mb-1"
            >
                <div>{{ message.user.data.username }}</div>
                <div class="pl-2">({{ $moment(message.created_at).format("DD.MM.'YY HH:mm") }})</div>
            </div>
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
            },
            chat: {
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