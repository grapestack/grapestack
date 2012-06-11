<cfif isDefined("form.title")>

    <cfhttp url="#request.couchServer#/_design/movies/_view/all?key=%22#form.id#%22"></cfhttp>
    
    <cfset revision = deserializeJSON(cfhttp.FileContent).rows[1].value._rev>

    <cfoutput>
        <cfsavecontent variable="body">
        {
           "title": "#form.title#",
           "director": "#form.director#",
           "type": "movie",
		   "_rev": "#revision#"
        }    
        </cfsavecontent>
    </cfoutput>
    
    <cfhttp url="#request.couchServer#/#form.id#" method="put">
        <cfhttpparam type="header" name="Content-Type" value="application/json">
        <cfhttpparam type="body" value="#body#">
    </cfhttp>
    
	<cflocation url="index.cfm">
    
<cfelse>

	<cfif NOT isDefined("url.id")>
            
		<cflocation url="index.cfm">   
        
	<cfelse>

    <cfhttp url="#request.couchServer#/_design/movies/_view/all?key=%22#url.id#%22"></cfhttp>
    
		<cfoutput>
            <form method="post" action="updateMovie.cfm">
            title: <input type="text" name="title" value="#deserializeJSON(cfhttp.FileContent).rows[1].value.title#"><br />
            director: <input type="text" name="director" value="#deserializeJSON(cfhttp.FileContent).rows[1].value.director#"><br />
 			<input type="hidden" name="id" value="#url.id#" />       
            <input type="submit" value="Update Movie" />
            </form>
        </cfoutput>    

    </cfif>

</cfif>