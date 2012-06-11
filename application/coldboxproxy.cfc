<cfcomponent name="coldboxproxy" output="false" extends="coldbox.system.remote.ColdboxProxy">

  <cffunction name="process" output="false" returnFormat="plain" access="remote" returntype="any"  hint="Process a remote call and return data/objects back.">
      <!--- Added a structure to contain arguments passed by the JavaScript function --->
      <cfargument name="proxyargs" required="no" type="any">



      <cfset var results = "">
   
      <!--- Anything before --->
      <!--- Append the args structure to the Arguments structure --->
      <cfif #isDefined("proxyargs")#>
      <cfset StructAppend(arguments, proxyargs)>
      </cfif>
	
	
<cfset doRoute = false>	
	
<cfif #isDefined("arguments.route")#>
	
<cfset url["PATH_INFO"] = '#arguments.route#'>

<cfset doRoute = true>

</cfif>

<cfif #isDefined("arguments.restVars")#>
	

<cfif listLen(arguments.restVars, '?') gt 1>
	<cfset url["PATH_INFO"] = '#listGetAt(arguments.restVars,1)#'>
	<cfset var thisArg = listGetAt(arguments.restVars,2,'?')>
	<cfset arguments["#listGetAt(thisArg, 1, '=')#"] = #listGetAt(thisArg, 2, '=')#>


<cfelse>
	<cfset url["PATH_INFO"] = '#arguments.restVars#'>
</cfif>

<cfset doRoute = true>

</cfif>

<cfif doRoute eq true>

<cfset id = structNew()>

<cfscript>
var controller = getController();
var event = controller.getRequestService().getContext();
</cfscript>

<cfscript>
//getInterceptor("SES").preProcess(event,id);
getInterceptor("SES").onRequestCapture(event,id);
</cfscript>
  

      <!--- Call the actual proxy 
      <cfset results = super.process(argumentCollection=arguments)>
	--->
	

	<cfset arguments["event"] = "#event.getCurrentEvent()#">



</cfif>



      <cfset structDelete(arguments, "proxyargs")>

      <cfset results = super.process(argumentCollection=arguments)>
   
      <!--- Anything after --->

<cfif #isDefined("request.noSerialize")# and #request.noSerialize# eq true>
      <cfreturn results>
<cfelse>

   
<cfif NOT isDefined("returnFormat")>
      <cfreturn serializeJSON(results)>
<cfelseif isDefined("returnFormat") and returnFormat is not 'json' and NOT isDefined("arguments.callback")>
	<cfreturn serializeJSON(results)>
<cfelse>

<cfreturn results>

</cfif>

</cfif>
  </cffunction>
     
  <cffunction name="processFlex" output="false" access="remote" returntype="any" returnFormat="JSON" hint="Process a remote call and return data/objects back.">
    <!--- Added a structure to contain arguments passed by the JavaScript function --->
    <cfargument name="proxyargs" required="no" type="any">
    <cfset var results = "">
 
    <!--- Anything before --->
    <!--- Append the args structure to the Arguments structure --->
    <cfif #isDefined("proxyargs")#>
    <cfset StructAppend(arguments, proxyargs)>
    </cfif>

 
    <!--- Call the actual proxy --->
    <cfset results = super.process(argumentCollection=arguments)>
 
    <!--- Anything after --->
    <cfreturn results>
</cffunction>
    
</cfcomponent>
