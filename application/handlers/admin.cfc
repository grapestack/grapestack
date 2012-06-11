<cfcomponent output="false">

<cfproperty name="hasher" inject="coldbox:myPlugin:hasher" scope="cachebox" ref="testing">
<cfproperty name="ORMService" inject="coldbox:plugin:ORMService" scope="instance">

	<cfscript>
		this.event_cache_suffix = "";
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.aroundHandler_only = "";
		this.aroundHandler_except = "";		
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>

	<!--- Default Action --->
	<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
        
	    <cfset event.setLayout("Layout.Home")>
		<cfset event.setView("admin")>
        
	</cffunction>
    
	<cffunction name="users" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
        <cfset var roleID = "">
        
	    <cfset event.setLayout("Layout.Home")>
		<cfset event.setView("admin/users")>
        
        <cfif isDefined("rc.item")>
        
            <cfswitch expression="#rc.item#">
            
                <cfcase value="manage">
                   
					<cfif isDefined("rc.subItem")>
                    
                        <cfswitch expression="#rc.subItem#">
                        
                            <cfcase value="edit">
                            
                            	<cfset rc.user = EntityLoad('user', rc.itemID)[1]>
                            
                            </cfcase>
                            
                            <cfcase value="create">
                            
                            	<cfset rc.newUser = EntityNew('user')>
                                <cfset rc.newUser.setEmail(rc.email)>
                                <cfset rc.newUser.setPassword(rc.password)>
                                
                                <cfloop list="#rc.roles#" index="roleID">
									<cfset rc.role = EntityLoad('role', roleID)>
                                    <cfset rc.newUser.addRoles(rc.role[1])>
                                </cfloop>
                                
                                <cfset EntitySave(rc.newUser)>
                                <cfset setNextRoute("admin/users/manage")>
                                                            
                            </cfcase>
                            
                            <cfcase value="update">
                                                        
                            	<cfset rc.user = EntityLoad('user', rc.itemID)[1]>
                                <cfset rc.user.setEmail(rc.email)>
                                <cfset rc.user.setPassword(rc.password)>
                                
                                <cfset local.newRoles = []>
                                
                                <cfloop list="#rc.roles#" index="roleID">
									<cfset rc.role = EntityLoad('role', roleID)>
                                    <cfset arrayAppend(local.newRoles, rc.role[1])>
                                </cfloop>
                                
                                <cfset rc.user.setRoles(local.newRoles)>
                                <cfset EntitySave(rc.user)>
                                <cfset setNextRoute("admin/users/manage")>
                                
                            </cfcase>
                            
                        </cfswitch>
                        
                    <cfelse>
                        
	                    <cfset rc.users = entityLoad('user')>
                        
                    </cfif>                  
                    
                </cfcase>
                
            </cfswitch>
        
        </cfif>
        
	</cffunction>

	<cffunction name="franchise" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
        <cfset var roleID = "">
        
	    <cfset event.setLayout("Layout.Home")>
		<cfset event.setView("admin/franchise")>
        
        <cfif isDefined("rc.item")>
        
            <cfswitch expression="#rc.item#">
            
                <cfcase value="manage">
                   
					<cfif isDefined("rc.subItem")>
                    
                        <cfswitch expression="#rc.subItem#">
                        
                            <cfcase value="edit">
                            
                            	<cfset rc.franchise = EntityLoad('franchise', rc.itemID)[1]>
                            
                            </cfcase>
                            
                            <cfcase value="create">
                            
                            	<cfset rc.newFranchise = EntityNew('franchise')>
                                <cfset rc.newFranchise.setFranchiseName(rc.franchiseName)>
                                
                                <cfset EntitySave(rc.newFranchise)>
                                <cfset setNextRoute("admin/franchise/manage")>
                                                            
                            </cfcase>
                            
                            <cfcase value="update">
                                                        
                            	<cfset rc.franchise = EntityLoad('franchise', rc.itemID)[1]>
                                <cfset rc.franchise.setFranchiseName(rc.franchiseName)>
                                
                                <cfset EntitySave(rc.franchise)>
                                <cfset setNextRoute("admin/franchise/manage")>
                                
                            </cfcase>
                            
                        </cfswitch>
                        
                    <cfelse>
                        
	                    <cfset rc.franchises = entityLoad('franchise')>
                        
                    </cfif>                  
                    
                </cfcase>
                
            </cfswitch>
        
        </cfif>
        
	</cffunction>

	<!--- onMissingAction --->
	<cffunction name="onMissingAction" returntype="void" output="false" hint="Executes if a request action (method) is not found in this handler">
		<cfargument name="event" >
		<cfargument name="missingAction" 	hint="The requested action string"/>
		<cfargument name="eventArguments" 	hint="The event arguments an event is executed with (if any)"/>
		<cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>


</cfcomponent>