<cfoutput>
<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<title>nxChat</title>

	<meta name="description" content="Chris created coldbox template with vuejs components and tailwind">
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
</body>
</html>
</cfoutput>
