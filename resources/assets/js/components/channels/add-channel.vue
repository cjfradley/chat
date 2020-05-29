<template>
    <div class="p-5">
        <h1 class="font-md">Find an interesting channel to subscribe to</h1>
        <v-select
            :options="channels"
            v-model="channelToSubscribeTo"
            label="title"
            :placeholder="channels.length ? 'find channel' : 'no channels to subcsribe to'"
            class="v-select-style"
        >
            <template v-slot:no-options="{ search, searching }">
                no channels to subcsribe to
            </template>
        </v-select>
        <p>
            {{ channelToSubscribeTo }}
        </p>
    </div>
</template>

<script>
    import { mapGetters, mapActions } from 'vuex'

    export default {
        data () {
            return {
                channelToSubscribeTo: null
            }
        },
        computed: {
            ...mapGetters({
                channels: 'channel/channels'
            })
        },
        mounted () {
            this.getChannels()
        },
        methods: {
            ...mapActions({
                getChannels: 'channel/getChannels'
            })
        }
    }
</script>