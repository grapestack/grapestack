<form method="post" action="addMovie.cfm">

    title: <input type="text" name="title"><br />
    
    <cfoutput>
    director: <input type="text" name="director" value="#url.director#"><br />
    </cfoutput>
    
    <input type="submit" value="Add Movie" />

</form>

<hr  />

<cfhttp url="#request.couchServer#/_design/movies/_view/total_by_director?startkey=%22#url.director#%22&endkey=%22#url.director#%22&group_level=1"></cfhttp>

<cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="director">
        #director.key# - #director.value#<br />
    </cfloop> 
</cfoutput>

<hr  />

<cfhttp url="#request.couchServer#/_design/movies/_view/by_director?key=%22#url.director#%22"></cfhttp>

<cfdump var="#deserializeJSON(cfhttp.FileContent)#">

<cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="movie">
        #movie.value.title# - <a href="updateMovie.cfm?id=#movie.value._id#">edit</a> - <a href="deleteMovie.cfm?id=#movie.value._id#">delete</a><br />
    </cfloop> 
</cfoutput>