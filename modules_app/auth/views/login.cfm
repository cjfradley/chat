<cfoutput>
    <div class="mx-auto w-1/2 max-w-xs mt-10">
        <h1 class="text-gray-700 font-bold text-2xl mb-5 mx-auto text-center">Login</h1>
        <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" action="#event.buildLink( 'auth.login' )#" method="post">
            <div class="mb-4">
                <cfif flash.exists("errors")>
                    <div class="text-red-500 font-bold mb-4">#flash.get("errors")#</div>
                <cfelseif flash.exists("info")>
                    <div class="text-blue-500 font-bold mb-4">#flash.get("info")#</div>
                </cfif>
                <label class="block text-gray-700 text-sm font-bold mb-2" for="email">
                    Email
                </label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="email" type="email" placeholder="Email" name="email">
                </div>
                <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="password">
                    Password
                </label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="password" type="password" placeholder="******************" name="password">
                </div>
                <div class="text-center">
                    <button type="submit" class="mb-5 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline w-full" type="button">
                        Sign In
                    </button>
                    <a class="mb-5 block align-baseline font-bold text-sm text-yellow-600" href="#event.buildLink( 'auth.register' )#">
                        Register
                    </a>
                    <a href="#event.buildLink( 'auth.passwordrecovery' )#" class="align-baseline text-sm text-gray-700 hover:text-blue-800 text-center">
                        Forgot Password?
                    </a>
                </div>
            </div>
        </form>
    </div>
</cfoutput>