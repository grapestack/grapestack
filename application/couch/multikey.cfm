<cfsavecontent variable="body">
{"keys": ["2", "5"]}
</cfsavecontent>

<cfhttp url="#request.couchServer#/_design/movies/_view/all" method="post">
        <cfhttpparam type="header" name="Content-Type" value="application/json">
        <cfhttpparam type="body" value="#body#">
</cfhttp>	

<cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="movie">
        #movie.value.title#
         - <a href="updateMovie.cfm?id=#movie.value._id#">edit</a>
         - <a href="deleteMovie.cfm?id=#movie.value._id#">delete</a>
         - <a href="director.cfm?director=#movie.value.director#">all by #movie.value.director#</a><br />
    </cfloop> 
</cfoutput>