<cfcomponent name="SecurityService" hint="This is a security service model object" output="false" cache="true" cachetimeout="20">
<cfproperty name="ORMService" inject="coldbox:plugin:ORMService" scope="instance">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

<cffunction name="init" access="public" returntype="any" output="false">


  <cfreturn this>
</cffunction>
        
<!------------------------------------------- PUBLIC ------------------------------------------->

<!--- User Validator for security --->
<cffunction name="userValidator" access="public" returntype="boolean" output="false" hint="Verifies that the user is in any permission">
        <!--- ************************************************************* --->
        <cfargument name="rule"         required="true" type="struct"   hint="The rule to verify">
        <cfargument name="messagebox" type="coldbox.system.plugins.messagebox" required="true" hint="The ColdBox messagebox plugin. You can use to set a redirection message"/>
        <cfargument name="controller" type="coldbox.system.web.controller" required="true" hint="The coldbox controller" />
        <!--- ************************************************************* --->
        <!--- Local call to get the user object from the session         <cfset var oUser = getUserSession()> --->

        <!--- The results boolean variable I will return --->
        <cfset var results = false>
        <!--- The permission I am checkin --->
        <cfset var thisPermission = "">
                                
		<cfset session.myQuery = arguments.rule>
        <cfset session.roles = "test">
      
        <!--- Messagebox will be set with a custom message --->
        <cfif not results>
                <cfset arguments.messagebox.setMessage("warning","You are not authorized to view this page.")>
        </cfif> 
        
		<!--- Deny By Default --->
        <cfset results = false>
        
        <cfif #isDefined("session.User")#>
                
        	<cfset roles = rule.roles>
       
            <cfloop list="#roles#" index="thisRole">
            
                    <cfscript>
                    
                    // Base ORM Service
                    local.c = instance.ORMService.newCriteria( 'role' );
                    
                    // Examples
                    local.role = c.order("roleid", "asc").OR( c.restrictions.eq("rolename", thisRole) ).list();
                    
                    </cfscript>
            
                    <cfif session.User.hasRoles(local.role[1])>
                            <cfset results = true>
                    </cfif>
            </cfloop>

        </cfif>
        
        <!--- I now return whether the user can view the incoming rule or not --->
        <cfreturn results>
</cffunction>

</cfcomponent>