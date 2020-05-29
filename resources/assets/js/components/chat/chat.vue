<template>
    <div class="bg-gray-300 h-full flex flex-col justify-between">
        
        <template v-if="chat">

            <div v-if="showInfo" class="px-4 py-2">
                <chat-info></chat-info>
            </div>

            <div ref="messagesContainer" class="flex items-stretch h-full overflow-y-scroll no-scrollbar">
                <div class="self-end w-full max-h-full">
                    <div
                        v-for="message in messages"
                        :key="message.id"
                        class="py-2 px-4"
                    >
                        <message :message="message"></message>
                    </div>
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
    import { mapGetters, mapActions } from "vuex"

    export default {
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
            },
            showInfo () {
                return this.chat.type === 'group' || this.chat.type === 'channel'
            }
        },
        methods: {
            ...mapActions({
                addMessageToSpecificChat: 'chat/addMessageToSpecificChat'
            }),
            handleChatScroll () {
                this.$nextTick(() => {
                    var container = this.$refs.messagesContainer
                    if (container) {
                        container.scrollTop = container.scrollHeight
                    }
                })
            },
            handleMessageFromSocket (message) {
                this.addMessageToSpecificChat(message).then(() => {
                    this.handleChatScroll()
                })
            }
        }
    }
</script>