<cfif isDefined("form.title")>

    <cfhttp url="#request.couchServer#/_design/movies/_view/max_id"></cfhttp>

    <cfset newID = #deserializeJSON(cfhttp.FileContent).rows[1].value[1]# + 1>

    <cfoutput>

        <cfsavecontent variable="body">
        {
           "title": "#form.title#",
           "director": "#form.director#",
           "type": "movie"<!---,
            "_attachments":{"index.html":{"content_type":"text/html","data":"#ToBase64('<strong>Test Attachment Text</strong>')#"}}
			--->
        }    
        </cfsavecontent>
    </cfoutput>
    
    <cfhttp url="#request.couchServer#/#newID#" method="put">
        <cfhttpparam type="header" name="Content-Type" value="application/json">
        <cfhttpparam type="body" value="#body#">
    </cfhttp>

	<cflocation url="index.cfm">
    
    <!---
		<cfscript>
		http url='#request.couchServer#/' method='post' result='insertMovie' {
			httpparam type='body' value='{"title": "test","director": "test","type": "movie"}';
			httpparam type='header' value='application/json' name='Content-Type';
		};
		writeDump( deserializeJSON( insertMovie.fileContent ) );
		</cfscript>
	--->
    
    
<cfelse>

	<cflocation url="index.cfm">

</cfif>