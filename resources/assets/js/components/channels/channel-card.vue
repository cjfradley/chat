<template>
    <div class="transition duration-300 ease-in-out hover:shadow-2xl bg-gray-200 rounded-md p-4">
        <div class="flex justify-between items-center">
            <h1 class="text-lg font-bold">{{ channel.title }}</h1>
            <div
                v-if="!adminIsMe"
                @click.prevent="addRemoveChannel"
            >
                <Zondicon
                    v-if="alreadyAdded"
                    icon="MinusSolid"
                    class="fill-current text-gray-600 h-6 w-6"
                />
                <Zondicon
                    v-else
                    icon="AddSolid"
                    class="fill-current text-gray-600 h-6 w-6"
                />
            </div>
        </div>
        <h2>by <span class="font-bold">{{ channel.admin.data.username }} {{ adminIsMe ? '(is me)' : '' }}</span></h2>
        <div class="text-gray-600 text-sm mb-1">{{ $moment(channel.created_at).format('DD.MM.YYYY') }}</div>
        <p
            v-if="channel.body"
            class="cursor-default px-2 py-1 bg-gray-300"
            v-html="channel.body"
        />
    </div>
</template>

<script>
    import Zondicon from 'vue-zondicons'
    import { mapActions, mapGetters } from 'vuex'

    export default {
        props: {
            channel: {
                required: true,
                type: Object
            }
        },
        components: {
            Zondicon
        },
        computed: {
            ...mapGetters({
                chats: 'chat/chats',
                user: 'user/user'
            }),
            adminIsMe () {
                return this.channel.admin.data.id === this.user.id
            },
            alreadyAdded () {
                return this.chats.find(e => e.id === this.channel.id)
            }
        },
        methods: {
            ...mapActions({
                addChannel: 'chat/addChannel',
                removeChannel: 'chat/removeChannel'
            }),
            addRemoveChannel () {
                if (this.alreadyAdded) {
                    this.removeChannel(this.channel.id)
                    return
                }
                this.addChannel(this.channel)
            }
        }
    }
</script>