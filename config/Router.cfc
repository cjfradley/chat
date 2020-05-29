component{

	function configure(){
		// Set Full Rewrites
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 *
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 *
		 */

		// A nice healthcheck route example
		route("/healthcheck",function(event,rc,prc){
			return "Ok!";
		});

        // A nice RESTFul Route example
        addRoute(
			pattern="/api/users/:id/chats",
			handler="api.users",
			action = {
				GET = "chats"
			},
			name="api.users.chats"
        );
        addRoute(
			pattern="/api/messages",
			handler="api.messages",
			action = {
				POST = "store"
			},
			name="api.messages.store"
        );
        addRoute(
			pattern="/api/chats/:id/add-user",
			handler="api.chats",
			action = {
                POST = "addUser"
			},
			name="api.chats.addUser"
        );
        addRoute(
			pattern="/api/chats/:id/remove-user",
			handler="api.chats",
			action = {
                POST = "removeUser"
			},
			name="api.chats.removeUser"
        );
        addRoute(
			pattern="/api/chats/channels",
			handler="api.chats",
			action = {
                GET = "channels"
			},
			name="api.chats.channels"
        );
        addRoute(
			pattern="/api/chats/:id",
			handler="api.chats",
			action = {
                PATCH = "update"
			},
			name="api.chats.id"
        );
        addRoute(
			pattern="/api/chats",
			handler="api.chats",
			action = {
                POST = "store"
			},
			name="api.chats.store"
        );
        addRoute(
			pattern="/api/auth/user",
			handler="auth:api.user",
			action = {
				GET = "index"
			},
			name="api.auth.user"
        );
        
		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}