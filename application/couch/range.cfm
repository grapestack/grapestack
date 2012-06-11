<cfhttp url="#request.couchServer#/_design/movies/_view/all?startkey=%22#url.startKey#%22&endkey=%22#url.endKey#%22"></cfhttp>

<cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="movie">
        <a href="updateMovie.cfm?id=#movie.value._id#">#movie.value.title#</a><br />
    </cfloop> 
</cfoutput>