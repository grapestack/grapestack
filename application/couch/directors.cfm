<cfhttp url="#request.couchServer#/_design/movies/_view/directors_unique?group=true"></cfhttp>

<cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="director">
        <a href="director.cfm?director=#director.key#">#director.key#</a><br />
    </cfloop> 
  <br />
</cfoutput>