component {

	this.title 				= "ColdBox annotation security";
	this.author 			= "Chris Fradley";
	this.description 		= "ColdBox Module for authorization by application struct.";
	this.version			= "1.0.0";
	this.cfmapping 			= "auth";
    this.entryPoint 		= "/auth";

    // If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= false;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = false;
	// Model Namespace
	this.modelNamespace		= "auth";
	// Auto-map models
	this.autoMapModels		= true;

	function configure() {

        // SES Routes
		router
            .addRoute(
                pattern="/register",
                handler="main",
                action = {
                    POST = "store",
                    GET = "register"
                },
                name="auth.register"
            )
            .addRoute(
                pattern="/login",
                handler="main",
                action = {
                    POST = "attempt",
                    GET = "login"
                },
                name="auth.login"
            )
            .addRoute(
                pattern="/passwordrecovery",
                handler="main",
                action = {
                    POST = "attemptsetrecoverykey",
                    GET = "passwordrecovery"
                },
                name="auth.passwordrecovery"
            )
            .addRoute(
                pattern="/resetpassword/:recoverykey",
                handler="main",
                action = {
                    POST = "attemptreset",
                    GET = "resetpassword"
                },
                name="auth.resetpassword"
            )
            .route("/401", "main.permissionDenied")
            .route("/logout", "main.logout");
            
    }
    
    function onLoad() {
        controller.getInterceptorService().registerInterceptor(
            interceptorName = "SecuredEventInterceptor",
            interceptorClass = "#moduleMapping#.interceptors.SecuredEventInterceptor"
        );
    }

}