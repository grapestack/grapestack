<cfset key = "[%22Spielberg%22,%22Jurassic%20Park%22]">

<cfhttp url='#request.couchServer#/_design/movies/_view/by_director_and_title?key=["Spielberg","Jurassic Park"]'>

</cfhttp>

<cfoutput>
    <cfloop array="#deserializeJSON(cfhttp.FileContent).rows#" index="item">
        <cfdump var="#item#">
    </cfloop> 
</cfoutput>