component extends="coldbox.system.EventHandler" {

    property name="ChatService" inject="entityService:chat";
    property name="UserService" inject="entityService:user";
    property name="ormService" inject="BaseORMService@cborm";
    property name="fractal" inject="Manager@cffractal";
    property name="sessionStorage" inject="sessionStorage@cbstorages";
    property name="validationManager" inject="ValidationManager@cbvalidation";

    /**
	 * Store new chat
	 */
    function store( event, rc, prc ) secured
    {
        var data = {
            title = rc.title,
            type = rc.type,
            users = [sessionStorage.get("user").id],
            admin = sessionStorage.get("user").id,
            created_at = now()
        };

        var chat = ormService.populate(target=ormService.new("chat"), memento=data, composeRelationships=true);
        ormService.save(chat);

        return fractal.builder()
            .item( chat )
            .withTransformer( "chatTransformer" )
            .withSerializer("DataSerializer@cffractal")
            .convert();
    }

    /**
	 * Update chat
	 */
    function update( event, rc, prc ) secured
    {
        var chat = ChatService.getOrFail(rc.id);

        chat.setTitle(rc.title);
        chat.setBody(event.getValue("body", ''));

        var validation = validationManager.validate(chat);

        if (validation.hasErrors()) {
            event.setHTTPHeader(statusText="ERROR",statusCode=301);
            return validation.getAllErrorsAsJSON();
        }

        ChatService.save(chat);

        WsPublish('userChannel', 'new');

        event.setHTTPHeader(statusText="OK",statusCode=200);
        return "";
    }

    /**
	 * Add user to chat
	 */
    function addUser( event, rc, prc ) secured
    {
        var chat = ChatService.getOrFail(rc.id);
        var user = UserService.getOrFail(rc.userId);

        chat.addUser(user);

        ChatService.save(chat);

        if (!event.getValue("noPush", false)) {
            WsPublish('userChannel', 'new');
        }

        event.setHTTPHeader(statusText="OK",statusCode=200);
        return "";
    }

    /**
	 * Remove user from chat
	 */
    function removeUser( event, rc, prc ) secured
    {
        var chat = ChatService.getOrFail(rc.id);
        var user = UserService.getOrFail(rc.userId);

        chat.removeUser(user);

        ChatService.save(chat);

        WsPublish('userChannel', 'new');

        event.setHTTPHeader(statusText="OK",statusCode=200);
        return "";
    }


    
    /**
	 * Get all channels
	 */
    function channels( event, rc, prc ) secured
    {
        var channels = ChatService.findAllByType('channel');

        return fractal.builder()
            .collection( channels )
            .withTransformer("chatTransformer")
            .withIncludes("admin")
            .withSerializer("DataSerializer@cffractal")
            .convert();
    }


}