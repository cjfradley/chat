<!--- All methods in this helper will be available in all handlers,views & layouts --->
<cfscript>

    function isLoggedIn ()
    {
        var sessionStorage = wirebox.getInstance("sessionStorage@cbstorages");

        if (! sessionStorage.exists("user")) {
            return false;
        }

        return sessionStorage.get("user");
    }

</cfscript>