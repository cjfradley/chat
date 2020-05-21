<template>
    <div>
        <input
            v-model="message"
            @keyup="handleKeyPress"
            class="w-full py-2 px-4 rounded-lg block appearance-none leading-normal"
            type="text"
            placeholder="send a message"
        >
    </div>
</template>

<script>
    import axios from "axios";
    import { mapActions } from 'vuex';

    export default {
        props: {
            chat: {
                required: true,
                type: Object
            }
        },
        data () {
            return {
                message: ''
            }
        },
        methods: {
            ...mapActions({
                addMessageToChat: 'chat/addMessageToChat'
            }),
            handleKeyPress (e) {
                if (e.keyCode === 13) {
                    this.submitAnswer()
                }
            },
            resetMessage () {
                this.message = ''
                this.$emit('answered')
            },
            async submitAnswer () {
                try {
                    const response = await axios.post(`/api/messages`, {
                        userId: 2,
                        chatId: this.chat.id,
                        message: this.message
                    })
                    this.addMessageToChat(response.data.data)
                    this.resetMessage()
                } catch (error) {
                    if (error.response) {
                        console.log(error.response.data);
                        console.log(error.response.status);
                        console.log(error.response.headers);
                    } else if (error.request) {
                        console.log(error.request);
                    } else {
                        console.log(error.message);
                    }
                    console.log(error)
                }
            }
        }
    }
</script>