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

	<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>

        <cfset var rc = event.getCollection()>

		<cfset event.setLayout("Layout.FacebookAuth")>

		<cfif isDefined("code")>
            <cfset local.secret_key = "YOURFACEBOOKSECRETKEY"/>
            <cfset local.appID = "YOURFACEBOOKAPPID"/>
            <!--- Fetching the below URL will return to the application the access token which allows your application to access the users information --->
            <cfhttp url="https://graph.facebook.com/oauth/access_token" result="local.login1"> 
            <cfhttpparam name="client_id" value="#local.appID#" encoded="no" type="url">
            <cfhttpparam name="redirect_uri" value="http://YOURREDIRECTURL" encoded="no" type="url"> 
            <cfhttpparam name="client_secret" value="#local.secret_key#" encoded="no" type="url">
            <cfhttpparam name="code" value="#code#" encoded="no" type="url">
            </cfhttp>
            <cfset local.accesstoken=local.login1.filecontent>
        
            <cfif findNoCase('token=', local.accesstoken)>           
				<cfset start = findNoCase('token=', local.accesstoken) + 6>
                <cfset end = findNoCase('&', local.accesstoken, start)>
                <cfset local.newtoken = mid(local.accesstoken, start, end-start)>
                <cfset local.accesstoken = local.newtoken>
            </cfif>
        
            <cfhttp url="https://graph.facebook.com/me?access_token=#local.accesstoken#" result="local.profile"/>
            <cfif IsJSON(local.profile.filecontent)>
                <cfset local.fbUserID=DeserializeJSON(local.profile.filecontent).id>                 
            </cfif>
        
			<cfset rc.returnFormat = 'JSON'>
            <cfset rc.facebookID = local.fbUserID>
			<cfset rc.fbEmail=DeserializeJSON(local.profile.filecontent).email>  
            <cfset rc.fbToken = local.accessToken>
            <cfset rc.signedRequest = ''>
            
            <cfset runEvent("user.facebook")>
        
        </cfif>        
    
	</cffunction>
	
	<cffunction name="index" returntype="void" output="false" hint="My main event">
	<!---
	Facebook authentication logic goes here, will add soon
	--->
	</cffunction>

</cfcomponent>