<cfcomponent>
	
	<cffunction name="onReady" access="public" output="no" returntype="void">
    	<cfargument name="data" type="struct" required="yes">
		        
        <cfsavecontent variable="dumpVar">
        #now()#
        </cfsavecontent>
        <cffile action="write" file="/grape/sites/gateway.txt" nameconflict="overwrite" output="#dumpVar#">
        
	</cffunction>

</cfcomponent>