<form method="post" action="addMovie.cfm">
    title: <input type="text" name="title"><br />
    director: <input type="text" name="director"><br />
    <input type="submit" value="Add Movie" />
</form>

<hr>
<a href="directors.cfm">Directors</a>
<br />
<a href="directorCount.cfm">Count by director</a>
<br />
<a href="range.cfm?startKey=5&endKey=8">Range from 5 to 8</a>
<br />
<a href="multiple.cfm">By director and title</a>
<br />
<a href="multikey.cfm">Multiple keys</a>
<hr />

<cfhttp url="#request.couchServer#/_design/movies/_view/all"></cfhttp>
<cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="movie">
        #movie.value.title#
         - <a href="updateMovie.cfm?id=#movie.value._id#">edit</a>
         - <a href="deleteMovie.cfm?id=#movie.value._id#">delete</a>
         - <a href="director.cfm?director=#movie.value.director#">all by #movie.value.director#</a><br />
    </cfloop> 
</cfoutput>