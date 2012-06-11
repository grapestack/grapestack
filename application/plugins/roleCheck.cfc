<cfcomponent name="roleCheck" hint="This is a role plugin" extends="coldbox.system.plugin" output="false" cache="true" cachetimeout="20">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

<cffunction name="init" access="public" returntype="any" output="false">
  <cfargument name="controller" type="any" required="true">
    
  <cfset super.Init(arguments.controller) />
  <cfset setpluginName("Role Plugin")>
  <cfset setpluginVersion("1.0")>
  <cfset setpluginDescription("This is a Role plugin.")>
  <!--- Any constructor code you want --->

  <cfreturn this>
</cffunction>
        
<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction name="check" output="false" access="public" returntype="string" hint="Check a role">
    <cfargument name="role" type="any" required="yes">
    <cfargument name="user" type="any" required="no">
    
    <cfset var event = controller.getRequestService().getContext()>
    <cfset var rc = event.getCollection()>
    
    <cfset local.check = entityLoad('role',{rolename=role})>   
    
    <cfif isDefined("arguments.user")>
    	<cfset local.user = arguments.user>
    <cfelseif isDefined("session.User")>
    	<cfset local.user = session.User>
	<cfelse>
    	<cfreturn false>
    </cfif>
    
	<cfif arrayLen(local.check) and local.user.hasRoles(local.check[1])>
		<cfreturn true>
    <cfelse>
    	<cfreturn false>
    </cfif>   

</cffunction>

</cfcomponent>