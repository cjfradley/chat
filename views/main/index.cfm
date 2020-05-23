<cfoutput>
    <div class="jumbotron">
        <cfdump var="#isLoggedIn()#">
        
            <a href="auth/logout">Logout</a>
        
            <a href="auth/login">Login</a>
        
    </div>
</cfoutput>