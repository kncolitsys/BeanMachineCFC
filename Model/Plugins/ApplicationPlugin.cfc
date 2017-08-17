
<cfcomponent displayname="ApplicationPlugin" extends="MachII.framework.Plugin" hint="I do initialization tasks.">
		
	<cffunction name="configure" access="public" returntype="void" output="false">								
		<cfscript>		
			var pm = getAppManager().getPropertyManager();
			// get some constants from the xml file			
			var dsn = pm.getProperty("dsn"); 	
			var beanAppName  = pm.getProperty("BeanAppName"); 	
			var Srctemplatepath = expandpath(pm.getProperty("SrcTemplatePath")) & "\"; 	
			var NewBeanPath  = expandpath(pm.getProperty("NewBeanPath")) & "\";
			var CSVpath  =     expandpath(pm.getProperty("CSVpath")) & "\";



			// create a bean of application constants and store it in properties
		 	variables.appConstants = createObject("component", "BeanMachine.model.applicationConstantsBean").init(dsn,beanAppName,Srctemplatepath,NewBeanPath,csvpath);
			pm.setProperty("appConstants", variables.appConstants);

variables.Libraryservices = createObject("component", "BeanMachine.model.grinder.GrinderServices").init(dsn,Srctemplatepath,NewBeanPath,csvpath);




	
		 </cfscript>
 
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="preProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />				
	</cffunction>
	
	<cffunction name="preEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<!--- <cfoutput>&nbsp;SimplePlugin.preEvent()<br /></cfoutput> --->
		<cfscript>
			var event = arguments.eventContext.getCurrentEvent();
			
			// insert the application constants in each event
			event.setArg("appConstants",variables.appConstants); 			
			// set the session user transfer object in the event  using the facade			
			event.setarg("LibraryServices", variables.LibraryServices);
		</cfscript>		       
	</cffunction>
	
	<cffunction name="postEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postEvent()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.preView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postProcess()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="handleException" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true" />
		<cfoutput>&nbsp;InitializationPlugin.handleException()<br /></cfoutput>
		<cfoutput>#arguments.exception.getMessage()#</cfoutput>
	</cffunction>

</cfcomponent>