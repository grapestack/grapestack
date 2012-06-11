<cfcomponent name="hasher" hint="This is a hash plugin" extends="coldbox.system.plugin" output="false" cache="true" cachetimeout="20">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

<cffunction name="init" access="public" returntype="any" output="false">
  <cfargument name="controller" type="any" required="true">
    
  <cfset super.Init(arguments.controller) />
  <cfset setpluginName("URL Plugin")>
  <cfset setpluginVersion("1.0")>
  <cfset setpluginDescription("This is a Date plugin.")>
  <!--- Any constructor code you want --->

  <cfreturn this>
</cffunction>
        
<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction name="getHash" output="false" access="public" returntype="string" hint="Make a hash">

  <cfset var event = controller.getRequestService().getContext()>
        <cfset var rc = event.getCollection()>


<!--- Generate 10 digit postkey --->
<cfset local.postkey = "" />
<cfloop index="i" from="0" to="9">
<!---
Choose whether this will be:
0=number
1=upper-case letter
2=lower-case letter --->
<cfset local.charSet = randRange( 0, 2 ) />

<cfswitch expression="#local.charSet#">
<cfcase value="0">
<cfset local.postkey = local.postkey & chr( randRange( 48, 57 ) ) />
</cfcase>
<cfcase value="1">
<cfset local.postkey = local.postkey & chr( randRange( 65, 90 ) ) />
</cfcase>
<cfcase value="2">
<cfset local.postkey = local.postkey & chr( randRange( 97, 122 ) ) />
</cfcase>
</cfswitch>
</cfloop>


<cfset local.charSet = randRange( 0, 3 ) />

<cfset local.charSet = local.charSet + 1>

<cfquery datasource="#getDatasource('read').getName()#" name="local.hashCheck">		
select userUUID
from users
where userUUID = '#local.postKey#'
</cfquery>

		<cfif local.hashCheck.recordCount lt 1>
			  <cfreturn #local.postkey#>
		<cfelse>

			  <cfreturn getHash()>
		</cfif>

  <cfscript>	


  </cfscript>


</cffunction>
   
</cfcomponent>