<cfcomponent name="hasher" hint="This is a utility plugin" extends="coldbox.system.plugin" output="false" cache="true" cachetimeout="20">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

<cffunction name="init" access="public" returntype="any" output="false">
  <cfargument name="controller" type="any" required="true">
    
  <cfset super.Init(arguments.controller) />
  <cfset setpluginName("Utility Plugin")>
  <cfset setpluginVersion("1.0")>
  <cfset setpluginDescription("This is a Utility plugin.")>
  <!--- Any constructor code you want --->

  <cfreturn this>
</cffunction>
        
<!------------------------------------------- PUBLIC ------------------------------------------->

	<cffunction name="uploadFile" access="public" hint="Facade to upload to a file, returns the cffile variable." returntype="any" output="false">
		<!--- ************************************************************* --->
		<cfargument name="FileField"         type="string" 	required="yes" 		hint="The name of the form field used to select the file">
		<cfargument name="Destination"       type="string" 	required="yes"      hint="The absolute path to the destination.">
		<cfargument name="NameConflict"      type="string"  required="false" default="overwrite" hint="Action to take if filename is the same as that of a file in the directory.">
		<cfargument name="Accept"            type="string"  required="false" default="" hint="Limits the MIME types to accept. Comma-delimited list.">
		<cfargument name="Attributes"  		 type="string"  required="false" default="Normal" hint="Comma-delimitted list of window file attributes">
		<cfargument name="Mode" 			 type="string"  required="false" default="755" 	  hint="The mode of the file for Unix systems, the default is 755">
		<!--- *************************************** --->

		<cfset var event = controller.getRequestService().getContext()>
        <cfset var rc = event.getCollection()>

		<cfset var results = "">
		
		<cffile action="upload" 
				filefield="#arguments.FileField#" 
				destination="#arguments.Destination#" 
				nameconflict="#arguments.NameConflict#" 
				accept="#arguments.Accept#"
				mode="#arguments.Mode#"
				Attributes="#arguments.Attributes#"
				result="results">
		
		<cfreturn results>
	</cffunction>

</cfcomponent>