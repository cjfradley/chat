<cfoutput>
    <div class="mx-auto w-1/2 max-w-xs mt-10">
        <h1 class="text-gray-700 font-bold text-2xl mb-5 mx-auto text-center">Reset password</h1>
        <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" action="#event.buildLink( 'auth/resetpassword/#rc.recoverykey#' )#" method="post">
            <div class="mb-4">
                <cfif flash.exists("errors")>
                    <div class="text-red-500 font-bold mb-4">#flash.get("errors")#</div>
                <cfelseif flash.exists("keyerror")>
                    <div class="text-red-500 font-bold mb-4 w-full text-center">
                        #flash.get("keyerror")#
                        <a class="inline-block align-baseline font-bold text-sm text-blue-400 hover:text-blue-800 mt-10" href="#event.buildLink( 'auth.passwordrecovery' )#">
                            Password recovery
                        </a>
                    </div>
                </cfif>
            </div>
            <cfif not flash.exists("keyerror")>
                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="password">
                        New Password
                    </label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="password" type="password" placeholder="******************" name="password">
                </div>
                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                        Reset
                    </button>
                </div>
            </cfif>
        </form>
    </div>
</cfoutput>