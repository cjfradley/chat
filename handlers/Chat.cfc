component extends="coldbox.system.EventHandler" {

	/**
	 * Default Action
	 */
    function index( event, rc, prc ) secured
    {
		event.setView( "chat" );
	}

}
