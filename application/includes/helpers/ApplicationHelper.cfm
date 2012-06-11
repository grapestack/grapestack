<!--- All methods in this helper will be available in all handlers,plugins,views & layouts --->

<cffunction name="security" output="yes" returntype="any" access="public">
<cfargument name="role" 		type="any"  required="true" hint="The role" >
<cfargument name="user" 		type="any"  required="false" hint="The user" >

    <cfreturn getMyPlugin('roleCheck').check(argumentCollection=arguments)>

<cfreturn true>

</cffunction>