<template>
    <div>
        <component :is="`chat-list-item-${chat.type}`" :chat="chat"></component>
    </div>
</template>

<script>
    export default {
        props: {
            chat: {
                required: true,
                type: Object
            }
        }
    }
</script>