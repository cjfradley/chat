<template>
    <div
        :class="{ 'justify-end': message.user.data.id === 2 }"
        class="flex"
    >
        <div
            :class="{ 'bg-gray-400': message.user.data.id === 2 }"
            class="p-2 bg-gray-200 rounded-md inline-block max-w-sm break-words"
        >
            {{ message.body }}
        </div>
    </div>
</template>

<script>
    export default {
        props: {
            message: {
                required: true,
                type: Object
            }
        }
    }
</script>