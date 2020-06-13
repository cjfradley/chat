<cfoutput>
    <div class="mx-auto w-1/2 max-w-xs mt-10">
        <h1 class="text-gray-700 font-bold text-2xl mb-5 mx-auto text-center">Register</h1>
        <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" action="#event.buildLink( 'auth.register' )#" method="post">
            <div class="mb-4">
                <cfif flash.exists("error")>
                    <div class="text-red-500 font-bold mb-4">#flash.get("error")#</div>
                </cfif>
                <label class="block text-gray-700 text-sm font-bold mb-2 <cfif flash.exists("error_username")>text-red-500</cfif>" for="username">
                    Username
                </label>
                <input
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline <cfif flash.exists("error_username")>border-red-300</cfif>"
                    id="username"
                    type="text"
                    placeholder="Username"
                    name="username"
                    <cfif flash.exists("username")>value="#flash.get("username")#"</cfif>
                >
                <cfif flash.exists("error_username")>
                    <small class="text-red-400 font-bold">#flash.get("error_username")#</small>
                </cfif>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2 <cfif flash.exists("error_email")>text-red-500</cfif>" for="email">
                    Email
                </label>
                <input
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline <cfif flash.exists("error_email")>border-red-300</cfif>"
                    id="email"
                    type="email"
                    placeholder="Email"
                    name="email"
                    <cfif flash.exists("email")>value="#flash.get("email")#"</cfif>
                >
                <cfif flash.exists("error_email")>
                    <small class="text-red-500 font-bold">#flash.get("error_email")#</small>
                </cfif>
            </div>
            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2 <cfif flash.exists("error_password")>text-red-500</cfif>" for="password">
                    Password
                </label>
                <input
                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline <cfif flash.exists("error_password")>border-red-300</cfif>"
                    id="password"
                    type="password"
                    placeholder="******************"
                    name="password"
                >
                <cfif flash.exists("error_password")>
                    <small class="text-red-500 font-bold">#flash.get("error_password")#</small>
                </cfif>
            </div>
            <div class="text-center">
                <button type="submit" class="mb-5 w-full bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button">
                    Register
                </button>
                <a class="mb-5 block align-baseline font-bold text-sm text-yellow-600" href="#event.buildLink( 'auth.login' )#">
                    Sign in
                </a>
            </div>
        </form>
    </div>
</cfoutput>