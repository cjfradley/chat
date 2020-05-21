component name="chatTransformer" extends="cffractal.models.transformers.AbstractTransformer" singleton {

    variables.defaultIncludes = [ "messages", "users" ];
    variables.availableIncludes = [ ];

    function transform( chat )
    {
        return {
            "id" = chat.getId(),
            "title" = chat.getTitle(),
            "body" = chat.getBody(),
            "created_at" = chat.getCreated_at()
        };
    }

    function includeMessages ( chat )
    {
        return collection (
            data = chat.getMessages(),
            transformer = wirebox.getInstance( "messageTransformer" ),
            serializer = wirebox.getInstance( "DataSerializer@cffractal" )
        );
    }

    function includeUsers ( chat )
    {
        return collection (
            data = chat.getUsers(),
            transformer = wirebox.getInstance( "userTransformer" ),
            serializer = wirebox.getInstance( "DataSerializer@cffractal" )
        );
    }
    
}