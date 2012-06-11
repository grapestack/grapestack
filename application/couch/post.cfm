    <cfhttp url="#request.couchServer#/_design/movies/_view/total_movies"></cfhttp>
    
    <cfset newID = deserializeJSON(cfhttp.FileContent).rows[1].value + 1>

    <cfoutput>
        <cfsavecontent variable="body">
        {
           "title": "test",
           "director": "test",
           "type": "movie"<!---,
            "_attachments":{"index.html":{"content_type":"text/html","data":"#ToBase64('<strong>Test Attachment Text</strong>')#"}}
			--->
        }    
        </cfsavecontent>
    </cfoutput>
    
    <cfhttp url="#request.couchServer#/" method="post">
        <cfhttpparam type="header" name="Content-Type" value="application/json">
        <cfhttpparam type="body" value="#body#">
    </cfhttp>
   
    <cfhttp url="#request.couchServer#/_design/movies/_view/all"></cfhttp>
    
    <cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="movie">
        #movie.value.title#
         - <a href="updateMovie.cfm?id=#movie.value._id#">edit</a>
         - <a href="deleteMovie.cfm?id=#movie.value._id#">delete</a>
         - <a href="director.cfm?director=#movie.value.director#">all by #movie.value.director#</a><br />
    </cfloop> 
    </cfoutput>