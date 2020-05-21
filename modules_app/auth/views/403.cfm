<cfoutput>
    <cfif structKeyExists(prc, "user")>
        <cfdump var="#prc.user#">
    </cfif>
    <b>NOT AUTHORIZED</b><br>
    U do not have the right permissions
</cfoutput>