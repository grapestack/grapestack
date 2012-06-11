<cfcomponent extends="Gateway" output="no">
	
	<---  The form fields which will be shown when adding a gateway instance via the Railo admin --->
	<---  argument names (see file Gateway.cfc):
		displayName, name, defaultValue, required, description, type, values --->
	<cfset variables.fields = array(
field("Interval (ms)", "interval", "500", true, "The interval between checks, in miliseconds", "text")
		, field("CFC Listener Function name", "listenerFunction", "onReady", true, "Called if the file exists", "text")
	) />

	<cffunction name="getClass" returntype="string" output="no">
		<cfreturn "" />
	</cffunction>
	
	<cffunction name="getCFCPath" returntype="string" output="no">
		<cfreturn "WEB-INF.railo.gateway.railo.extension.gateway.default" />
	</cffunction>
	
	<cffunction name="getLabel" returntype="string" output="no">
		<cfreturn "Grape Gateway" />
	</cffunction>
	
	<cffunction name="getDescription" returntype="string" output="no">
		<cfreturn "Grape default gateway" />
	</cffunction>
	
	<cffunction name="onBeforeUpdate" returntype="void" output="false">
		<cfargument name="cfcPath" required="true" type="string" />
		<cfargument name="startupMode" required="true" type="string" />
		<cfargument name="custom" required="true" type="struct" />
		<cfset var errors = [] />
		
	
		<---  interval --->
		<cfif not IsNumeric(custom.interval) or custom.interval LT 1 or int(custom.interval) neq custom.interval>
			<cfset arrayAppend(errors, "The interval [#custom.interval#] must be a numeric value greater than 0") />
		</cfif>


		<cfif arrayLen(errors)>
			<cfthrow message="The following error(s) occured while validating your input: <ul><li>#arrayToList(errors, '</li><li>')#</li></ul>" />
		</cfif>
	</cffunction>
	
	<cffunction name="getListenerCfcMode" returntype="string" output="no"
	hint="Returns either 'none' or 'required'">
		<cfreturn "required" />
	</cffunction>
	
	<cffunction name="getListenerPath" returntype="string" output="no"
	hint="Returns the path to the default Listener cfc">
		<cfreturn "WEB-INF.railo.extension.gateway.defaultListener" />
	</cffunction>
</cfcomponent>