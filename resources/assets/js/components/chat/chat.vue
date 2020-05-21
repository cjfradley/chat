<template>
    <div class="flex flex-col justify-end h-full bg-gray-300">
        <template v-if="chat">

            <div ref="messagesContainer" class="flex flex-col overflow-y-scroll max-h-full no-scrollbar">
                <div
                    v-for="message in messages"
                    :key="message.id"
                    class="py-2 px-4"
                >
                    <message :message="message"></message>
                </div>
            </div>

            <div class="px-4 py-2">
                <answer
                    :chat="chat"
                    @answered="handleChatScroll"
                ></answer>
            </div>

        </template>
    </div>
</template>

<script>
    import { mapGetters } from "vuex";

    import message from "./message";
    import answer from "./answer";

    export default {
        components: {
            message,
            answer
        },
        watch: {
            chat: function(e) {
                this.handleChatScroll()
            }
        },
        computed: {
            ...mapGetters({
                chat: 'chat/activeChat'
            }),
            messages () {
                return this.chat.messages.data.sort((a,b) => this.$moment(a.created_at).unix() - this.$moment(b.created_at).unix())
            }
        },
        methods: {
            handleChatScroll () {
                this.$nextTick(() => {
                    var container = this.$refs.messagesContainer
                    container.scrollTop = container.scrollHeight
                })
            }
        }
    }
</script>