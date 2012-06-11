<cfcomponent>
	
    
    <cfset state="stopped">
	
	<cffunction name="init" access="public" output="no" returntype="void">
		<cfargument name="id" required="false" type="string">
		<cfargument name="config" required="false" type="struct">
		<cfargument name="listener" required="false" type="component">
    	<cfset variables.id=id>
        <cfset variables.config=config>
        <cfset variables.listener=listener>
        
        <cflog text="init" type="information" file="grape">
        
	</cffunction>


	<cffunction name="start" access="public" output="no" returntype="void">
		<cfwhile state EQ "stopping">
        	<cfset sleep(10)>
        </cfwhile>
        <cfset variables.state="running">
        
        
        <cflog text="start" type="information" file="grape">              
        
        <!--- first execution --->
        <cfwhile variables.state EQ "running">
        	<cftry>
            
            	<cfset eventData = structNew()>
                <cfset eventData.test = 'testing'>
            
				<cfset variables.listener["onReady"](eventData)>
                
                <cfcatch>
                	<cflog text="#cfcatch.message#" type="Error" file="grape">
                </cfcatch>
            </cftry>
            <cfif variables.state NEQ "running">
            	<cfbreak>
            </cfif>
            <cfset sleep(config.interval)>
    	</cfwhile>
        <cfset variables.state="stopped">
        
	</cffunction>
    
    
	    

	<cffunction name="stop" access="public" output="no" returntype="void">
    	<cflog text="stop" type="information" file="grape">
		<cfset variables.state="stopping">
	</cffunction>

	<cffunction name="restart" access="public" output="no" returntype="void">
		<cfif state EQ "running"><cfset stop()></cfif>
        <cfset start()>
	</cffunction>

	<cffunction name="getState" access="public" output="no" returntype="string">
		<cfreturn state>
	</cffunction>

	<cffunction name="sendMessage" access="public" output="no" returntype="string">
		<cfargument name="data" required="false" type="struct">
		<cfreturn "ERROR: sendMessage not supported">
	</cffunction>    
    

</cfcomponent>