/**
 * Main Authentication module
 */
component extends="coldbox.system.EventHandler" singleton {

	// DI
    property name="UserService" inject="entityService:user";
    property name="fractal" inject="Manager@cffractal";
    property name="sessionStorage" inject="sessionStorage@cbstorages";

    /**
     * Show register view
     *
     * @event 
     * @rc 
     * @prc 
     */
    any function index( event, rc, prc )
    {

        if ( ! sessionStorage.exists('user')) {
            event.setHTTPHeader(statusCode=401, statusText='ERROR');
            return 'Unauthorized.';
        }

        var user = UserService.getOrFail(sessionStorage.get("user").id);

        return fractal.builder()
            .item( user )
            .withTransformer( "userTransformer" )
            .withSerializer("DataSerializer@cffractal")
            .convert();
    }

}