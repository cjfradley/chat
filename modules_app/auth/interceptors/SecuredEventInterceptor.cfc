component extends="coldbox.system.Interceptor"{

    property name="handlerService" inject="coldbox:handlerService";
    property name="sessionStorage" inject="sessionStorage@cbstorages";

    void function configure() {}

    function preProcess( event, interceptData ) {

        if ( event.getHTTPMethod() == "OPTIONS" ) {
            return;
        }

        var handlerBean = handlerService.getHandlerBean( event.getCurrentEvent() );

        if ( handlerBean.getHandler() == "" ) {
            return;
        }

        if ( ! handlerBean.isMetadataLoaded() ) {
            handlerService.getHandler( handlerBean, event );
        }
        var handlerMetadata = handlerBean.getHandlerMetadata();

        // check if events handler / action has secured annotations and relocate to 401 page if user not authenticated / authorized
        if(! _authorizedForHandler(handlerMetadata) || ! _authorizedForAction(handlerMetadata, event)) {
            relocate("auth.401");
        }

        return true;

    }
    
    private function _authorizedForHandler(handlerMetadata) {

        if (!structKeyExists( handlerMetadata, "secured") || handlerMetadata.secured == false) {
            return true;
        }

        // check if user is logged in
        if ( not sessionStorage.exists("user")) {
            return false;
        }

        // check if user has roles or permissions
        if (! _hasRolesOrPermissions(handlerMetadata)) {
            return false;
        }

        return true;

    }

     private function _authorizedForAction(handlerMetadata, event) {

        // check that function actually exists in handler
        if (!structKeyExists( handlerMetadata, "functions" )){
            return true;
        }
        var funcsMetadata = arrayFilter( handlerMetadata.functions, function( func ) {
            return func.name == event.getCurrentAction();
        });
        if(arrayIsEmpty( funcsMetadata )) {
            return true;
        }

        // check if action has 'secured' meta defined
        var targetActionMetadata = funcsMetadata[ 1 ];
        if ((!structKeyExists( handlerMetadata, "secured") || handlerMetadata.secured == false) &&
            (!structKeyExists( targetActionMetadata, "secured" ) || targetActionMetadata.secured == false)) {
            return true;
        }

        // check if user is logged in
        if ( not sessionStorage.exists("user")) {
            return false;
        }

        // check if user has roles or permissions
        if (! _hasRolesOrPermissions(targetActionMetadata)) {
            return false;
        }

        return true;

    }
    
    /**
     * Undocumented function
     *
     * @token 
     * @metaData 
     */
    private boolean function _hasRolesOrPermissions(metaData)
    {
        var loggedInStruct = sessionStorage.get("user");
        var noRole = false;
        var noPermission = false;

        // if role is defined, then check to see if user has role
        if (structKeyExists( metaData, "role" ) && metaData.role != false && metaData.role != '' ) {
            
            // check if user has one of the required roles
            // if so, then no need to check for extra permissions that might have been added
            for (userrole in loggedInStruct.role) {
                if (listFind(metaData.role, userrole.slug)) {
                    return true;
                }
            }

        } else {
            noRole = true;
        }

        // if extra permissions have been added, then check to see if user has at least one of these
        if (structKeyExists( metaData, "permissions" ) && metaData.permissions != false && metaData.permissions != '' ) {
            for (userpermissions in loggedInStruct.permissions) {
                if (listFind(metaData.permissions, userpermissions.slug)) {
                    return true;
                }
            }
        } else {
            noPermission = true;
        }

        // if none of these exist, return false because user does not have permission to access action
        return noRole && noPermission;
    }

}