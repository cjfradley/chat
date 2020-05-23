component name="chatTransformer" extends="cffractal.models.transformers.AbstractTransformer" singleton {

    variables.defaultIncludes = [ "messages", "users" ];
    variables.availableIncludes = [ "admin" ];

    function transform( chat )
    {
        return {
            "id" = chat.getId(),
            "title" = chat.getTitle(),
            "type" = chat.getType(),
            "body" = chat.getBody(),
            "adminId" = chat.adminId(),
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

    function includeAdmin ( chat )
    {
        return item (
            data = chat.getAdmin(),
            transformer = wirebox.getInstance( "userTransformer" ),
            serializer = wirebox.getInstance( "DataSerializer@cffractal" )
        );
    }
    
}