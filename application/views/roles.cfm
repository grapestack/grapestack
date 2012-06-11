<cfoutput>

<cfdump var="#rc.hasher#">

   	<cfloop array="#rc.users#" index="user">

    <cfset role = EntityLoad('role', 1)>   
    
    <cfif NOT user.hasRoles(role[1])>    
    
    <cfset temp = #user.addRoles(role[1])#>
	<cfset temp = ORMFlush()>
    
    </cfif>
    
    <cfset role = EntityLoad('role', 2)>   
    
    <cfif NOT user.hasRoles(role[1])>    
    
    <cfset temp = #user.addRoles(role[1])#>
	<cfset temp = ORMFlush()>
    
    </cfif>   
    
    <cfset role = EntityLoad('role', 3)>   
    
    <cfif NOT user.hasRoles(role[1])>    
    
    <cfset temp = #user.addRoles(role[1])#>
	<cfset temp = ORMFlush()>
    
    </cfif>
    
    <cfset temp = #user.setRoles(rc.results)#>

	<cfset temp = ORMFlush()>
    
    <cfif isDefined("session.User")>
    <cfdump var="#session.User#">
    </cfif>
    
    </cfloop>   
    
</cfoutput>