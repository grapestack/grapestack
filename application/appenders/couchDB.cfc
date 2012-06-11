<cfcomponent extends="coldbox.system.logging.AbstractAppender" 
			 output="false"
			 hint="couchDB appender">
	
	<!--- Init --->
	<cffunction name="init" access="public" returntype="couchDB" hint="Constructor" output="false" >
		<!--- ************************************************************* --->
		<cfargument name="name" 		type="string"  required="true" hint="The unique name for this appender."/>
		<cfargument name="properties" 	type="struct"  required="false" default="#structnew()#" hint="A map of configuration properties for the appender"/>
		<cfargument name="layout" 		type="string"  required="false" default="" hint="The layout class to use in this appender for custom message rendering."/>
		<cfargument name="levelMin"  	type="numeric" required="false" default="0" hint="The default log level for this appender, by default it is 0. Optional. ex: LogBox.logLevels.WARN"/>
		<cfargument name="levelMax"  	type="numeric" required="false" default="4" hint="The default log level for this appender, by default it is 5. Optional. ex: LogBox.logLevels.WARN"/>
		<!--- ************************************************************* --->
		<cfscript>
			// Init supertype
			super.init(argumentCollection=arguments);
			
			// Verify properties
			if( NOT propertyExists('host') ){
				$throw(message="Please define a couchDB host",type="couchDBAppender.MissingHost");
			}
			if( NOT propertyExists('database') ){
				$throw(message="Please define a couchDB database",type="couchDBAppender.MissingDatabase");
			}
			if( NOT propertyExists('port') ){
				$throw(message="Please define a couchDB port",type="couchDBAppender.MissingPort");
			}
			if( NOT propertyExists('logType') ){
				setProperty("logType","simple");
			}

			if( NOT reFindNoCase("^(simple)$", getProperty("logType")) ){
				$throw(message="Invalid logtype. Valid types are: simple",type="couchDBAppender.InvalidLogType");
			}			
									
			return this;
		</cfscript>
	</cffunction>	
	
	<!--- Log Message --->
	<cffunction name="logMessage" access="public" output="true" returntype="void" hint="Write an entry into the appender.">
		<!--- ************************************************************* --->
		<cfargument name="logEvent" type="coldbox.system.logging.LogEvent" required="true" hint="The logging event"/>
		<!--- ************************************************************* --->
		<cfscript>
			var entry = structnew();
			var loge = arguments.logEvent;
			var udfCall = "";
			
			// Render entry
			if( hasCustomLayout() ){
				entry = getCustomLayout().format(loge);
			}
			else{
				entry = "#severityToString(loge.getseverity())# #loge.getCategory()# #loge.getmessage()# ExtraInfo: #loge.getextraInfoAsString()#";
			}
			
			// Type of message
			if( getProperty("logType") eq "simple"){
				udfCall = variables.simpleLog;
			}
			else{
				udfCall = variables.simpleLog;
			}
			
			//Call it
			try{
				udfCall(entry);
			}
			catch(Any e){
				$log("ERROR","Error sending couchDB message of type #getProperty("logType")#. #e.message# #e.detail#");
			}
		</cfscript>	   
	</cffunction>
	
<!------------------------------------------- PRIVATE ------------------------------------------>

	<!--- simpleLog --->
	<cffunction name="simpleLog" output="false" access="private" returntype="void" hint="Log a simple message">
		<cfargument name="message" type="string" required="true" hint="The message to post"/>
		
		<cfset var msg = arguments.message>
           
        <cfoutput>
            <cfsavecontent variable="body">
            {
               "entry": "#msg#"
            }    
            </cfsavecontent>
        </cfoutput>
                
        <cfhttp url="http://#getProperty('host')#:#getProperty('port')#/#getProperty('database')#/" method="post">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="body" value="#body#">
        </cfhttp>       
        
	</cffunction>
	
	
</cfcomponent>