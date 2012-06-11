<cfhttp url="#request.couchServer#/_design/movies/_view/total_by_director?group_level=1"></cfhttp>

<cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="director">
        <a href="director.cfm?director=#director.key#">#director.key#</a>: #director.value#<br />
    </cfloop> 
</cfoutput>