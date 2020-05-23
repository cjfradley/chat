component extends="coldbox.system.EventHandler" {

    property name="ChatService" inject="entityService:chat";
    property name="UserService" inject="entityService:user";
    property name="ormService" inject="BaseORMService@cborm";
    property name="fractal" inject="Manager@cffractal";
    property name="sessionStorage" inject="sessionStorage@cbstorages";

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
	 * Add user to chat
	 */
    function addUser( event, rc, prc ) secured
    {

        var chat = ChatService.getOrFail(rc.id);
        var user = UserService.getOrFail(rc.userId);

        chat.addUser(user);

        ChatService.save(chat);

        WsPublish('userChannel', 'new');

    }
    



}