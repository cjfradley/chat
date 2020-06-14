<template>
    <div class="p-5">
        <h1 class="mb-2 text-xl">Find an interesting channel to subscribe to</h1>
        
        <div class="grid grid-cols-2 gap-4">
            <channel-card
                v-for="channel in channels"
                :channel="channel"
                :key="channel.id"
            ></channel-card>
        </div>
        
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