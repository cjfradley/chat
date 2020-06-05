<cfoutput>
<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<title>nxChat</title>

	<meta name="description" content="nxChat app for internal use only">
    <meta name="author" content="Chris Fradley">

	<!---Base URL --->
	<base href="#event.getHTMLBaseURL()#" />

	<!---css --->
	<link rel="stylesheet" type="text/css" href="#html.elixirPath( "css/app.css" )#" />

	<!--- If there are any extracted Vue styles, they will be in this file --->
	<cfscript>
        if ( getCache( "template" ).getOrSet( "vue-styles", function() {
            return fileExists( expandPath( html.elixirPath( "js/app.css" ) ) );
        } ) ) {
            writeOutput( '<link rel="stylesheet" type="text/css" href="#html.elixirPath( "js/app.css" )#" />' );
        }
    </cfscript>
</head>
<body data-spy="scroll" class="h-full">

	<!---Container And Views --->
	<div id="app" class="h-full">
		#renderView()#
	</div>

	<script src="#html.elixirPath( "js/runtime.js" )#"></script>
    <script src="#html.elixirPath( "js/vendor.js" )#"></script>
    <script src="#html.elixirPath( "js/app.js" )#"></script>
    
    <script>
        function openHandler(){
            //Subscribe to the channel, pass in headers for filtering later
            // ChatSocket.subscribe('chatChannel',{name: 'TheUserName', UserID: 'TheUserID', AccountID: 'AnUniqueID' });
        }
        // this is the receiving function
        function msgHandler(message){
            // if condition to display the message to the user who are sending and receiving
            switch (message.channelname) {
                case 'chatChannel':
                    app.$refs.chat.handleMessageFromSocket(message)
                    break;
                case 'userChannel':
                    app.$refs.chatList.handleMessageFromSocket(message)
                    break;
                default:
                    break;
            }
        }

        function errHandler(error) {
            console.log(error);
        }
    </script>

    <cfwebsocket
        name="ChatSocket"
        onOpen="openHandler"
        onMessage="msgHandler"
        onError="errHandler"
        subscribeTo="chatChannel,userChannel"
    ></cfwebsocket>

</body>
</html>
</cfoutput>
