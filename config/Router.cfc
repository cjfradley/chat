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
        
		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}