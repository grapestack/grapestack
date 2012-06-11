<cfcomponent extends="Cache">
    <cfset fields=array(
			field(	displayName="Membase Server Host",
					name="host",
					defaultValue="localhost:11211",
					required=true,
					description="membase server moxi (or standalone install)  host and port. Ex: localhost:11211",
					type="text"
				)		
	)>

	<cffunction name="getClass" returntype="string">
    	<cfreturn "railo.extension.io.cache.membase.MembaseCache">
    </cffunction>
    
	<cffunction name="getLabel" returntype="string" output="no">
    	<cfreturn "Membase Server Cache">
    </cffunction>

	<cffunction name="getDescription" returntype="string" output="no">
    	<cfset var c="">
    	<cfsavecontent variable="c">
		This is the Membase Cache implementation for Railo.
        </cfsavecontent>
    	<cfreturn trim(c)>
    </cffunction>

</cfcomponent>