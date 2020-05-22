component name="messageTransformer" extends="cffractal.models.transformers.AbstractTransformer" singleton {

    variables.defaultIncludes = [ "user" ];
    variables.availableIncludes = [ "chat" ];

    function transform( message ) {
        return {
            "id" = message.getId(),
            "body" = message.getBody(),
            "created_at" =  message.getCreated_at()
        };
    }

    function includeUser ( message )
    {
        return item (
            data = message.getUser(),
            transformer = wirebox.getInstance( "userTransformer" ),
            serializer = wirebox.getInstance( "DataSerializer@cffractal" )
        );
    }

    function includeChat ( message )
    {
        return item (
            data = message.getChat(),
            transformer = wirebox.getInstance( "chatTransformer" ),
            serializer = wirebox.getInstance( "DataSerializer@cffractal" )
        );
    }
    
}