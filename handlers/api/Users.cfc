component extends="coldbox.system.EventHandler" {

    property name="UserService" inject="entityService:user";
    property name="ChatService" inject="entityService:chat";
    property name="sessionStorage" inject="sessionStorage@cbstorages";
    property name="fractal" inject="Manager@cffractal";
    
    /**
	 * Get Users chats
	 */
    function chats( event, rc, prc ) secured
    {
        var user = UserService.getOrFail(rc.id);

        var chats = user.getChats();

        return fractal.builder()
            .collection( chats )
            .withTransformer( "chatTransformer" )
            .withSerializer("DataSerializer@cffractal")
            .convert();
	}

}