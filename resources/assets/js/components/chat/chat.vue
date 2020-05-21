<template>
    <div class="h-full bg-gray-300">
        <template v-if="chat">
            <div
                v-for="message in chat.messages.data"
                :key="message.id"
            >
                {{ message.body }}
            </div>
        </template>
    </div>
</template>

<script>
    import { mapGetters } from "vuex";

    export default {
        computed: {
            ...mapGetters({
                chat: 'chat/activeChat'
            })
        }
    }
</script>