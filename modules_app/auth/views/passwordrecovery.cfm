<cfoutput>
    <div class="mx-auto w-1/2 max-w-xs mt-10">
        <h1 class="text-gray-700 font-bold text-2xl mb-5 mx-auto text-center">Password recovery</h1>
        <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" action="#event.buildLink( 'auth.passwordrecovery' )#" method="post">
            <div class="mb-4">
                <cfif flash.exists("info")>
                    <div class="text-blue-500 font-bold mb-4">#flash.get("info")#</div>
                </cfif>
                <label class="block text-gray-700 text-sm font-bold mb-2" for="email">
                    Email
                </label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="email" type="email" placeholder="Email" name="email">
            </div>
            <div class="text-center">
                <button type="submit" class="w-full mb-5 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button">
                    Recover
                </button>
                <a class="mb-5 block align-baseline font-bold text-sm text-yellow-600" href="#event.buildLink( 'auth.login' )#">
                    Sign in
                </a>
            </div>
        </form>
    </div>
</cfoutput>