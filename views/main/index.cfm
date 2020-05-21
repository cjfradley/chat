<cfoutput>
    <div class="jumbotron">
        <cfif isLoggedIn()>
            <a href="auth/logout">Logout</a>
        <cfelse>
            <a href="auth/login">Login</a>
        </cfif>
    </div>
</cfoutput>