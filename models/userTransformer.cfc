component name="userTransformer" extends="cffractal.models.transformers.AbstractTransformer" singleton {

    variables.defaultIncludes = [ ];
    variables.availableIncludes = [ ];

    function transform( user ) {
        return {
            "id" = user.getId(),
            "username" = user.getUsername()
        };
    }
    
}