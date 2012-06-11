<cfcomponent name="security" hint="This is a security plugin" output="false" cache="true" cachetimeout="20">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

<cffunction name="init" access="public" returntype="any" output="false">

</cffunction>
        

<cffunction name="getRules" access="public" returntype="query" output="false" hint="User Security">

<cfset myQuery = QueryNew("whitelist, securelist, roles, permissions, redirect", "VarChar, VarChar, VarChar, VarChar, VarChar")>

<!--- Make a new row in the query --->
<cfset newRow = QueryAddRow(MyQuery, 1)>

<!--- Set the values of the cells in the query --->
<cfset temp = QuerySetCell(myQuery, "whitelist", "", 1)>
<cfset temp = QuerySetCell(myQuery, "securelist", "General.Test", 1)>
<cfset temp = QuerySetCell(myQuery, "roles", "user", 1)>
<cfset temp = QuerySetCell(myQuery, "permissions", "", 1)>
<cfset temp = QuerySetCell(myQuery, "redirect", "secure", 1)>

<!--- Make a new row in the query --->
<cfset newRow = QueryAddRow(MyQuery, 1)>

<!--- Set the values of the cells in the query --->
<cfset temp = QuerySetCell(myQuery, "whitelist", "", 2)>
<cfset temp = QuerySetCell(myQuery, "securelist", "General.admin", 2)>
<cfset temp = QuerySetCell(myQuery, "roles", "admin", 2)>
<cfset temp = QuerySetCell(myQuery, "permissions", "", 2)>
<cfset temp = QuerySetCell(myQuery, "redirect", "secure", 2)>
      
<!--- Make a new row in the query --->
<cfset newRow = QueryAddRow(MyQuery, 1)>

<!--- Set the values of the cells in the query --->
<cfset temp = QuerySetCell(myQuery, "whitelist", "", 3)>
<cfset temp = QuerySetCell(myQuery, "securelist", "admin", 3)>
<cfset temp = QuerySetCell(myQuery, "roles", "admin", 3)>
<cfset temp = QuerySetCell(myQuery, "permissions", "", 3)>
<cfset temp = QuerySetCell(myQuery, "redirect", "secure", 3)>

<!--- Make a new row in the query --->
<cfset newRow = QueryAddRow(MyQuery, 1)>

<!--- Set the values of the cells in the query --->
<cfset temp = QuerySetCell(myQuery, "whitelist", "", 4)>
<cfset temp = QuerySetCell(myQuery, "securelist", "dashboard", 4)>
<cfset temp = QuerySetCell(myQuery, "roles", "user", 4)>
<cfset temp = QuerySetCell(myQuery, "permissions", "", 4)>
<cfset temp = QuerySetCell(myQuery, "redirect", "secure", 4)>
      
            
        <cfreturn myQuery>
        
</cffunction>

</cfcomponent>