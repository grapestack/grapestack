<cfif isDefined("url.id")>

    <cfhttp url="#request.couchServer#/_design/movies/_view/all?key=%22#url.id#%22"></cfhttp>
    
    <cfset revision = deserializeJSON(cfhttp.FileContent).rows[1].value._rev>
    
    <cfhttp url="#request.couchServer#/#url.id#?rev=#revision#" method="delete">
        <cfhttpparam type="header" name="Content-Type" value="application/json">
    </cfhttp>
    
	<cflocation url="index.cfm">
    
<cfelse>

	<cflocation url="index.cfm">

</cfif>