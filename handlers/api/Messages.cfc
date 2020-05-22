component extends="coldbox.system.EventHandler" {

    property name="ormService" inject="BaseORMService@cborm";
    property name="sessionStorage" inject="sessionStorage@cbstorages";
    property name="ChatService" inject="entityService:chat";
    property name="fractal" inject="Manager@cffractal";
    
    /**
	 * Post message
	 */
    function store( event, rc, prc ) secured
    {
        // CHECK IF CHAT EXISTS

        
        // CREATE NEW MESSAGE
        var data = {
            user: rc.userId,
            chat: rc.chatId,
            body: rc.message,
            created_at: now()
        };
        var message = ormService.populate(target=ormService.new("message"), memento=data, composeRelationships=true);

        ormService.save(message);

        // publish to channel
        var socketMessage = fractal.builder()
            .item( message )
            .withTransformer( "messageTransformer" )
            .withSerializer("DataSerializer@cffractal")
            .withIncludes( "chat" )
            .withExcludes( "chat.messages,chat.users,chat.body,chat.title,chat.created_at" )
            .convert();
            
        WsPublish('chatChannel', socketMessage);

        return fractal.builder()
            .item( message )
            .withTransformer( "messageTransformer" )
            .withSerializer("DataSerializer@cffractal")
            .convert();
	}

}