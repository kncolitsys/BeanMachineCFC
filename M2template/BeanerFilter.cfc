<!---
	COMPONENT: <beanname>BeanerFilter
	AUTHOR:<author>
	DATE: <Beandate>
	PURPOSE: This filter makes sure an instance of the <benaname> bean is available in the event.
	CHANGE HISTORY:
--->

<cfcomponent display="<beanname>BeanerFilter" extends="MachII.framework.EventFilter" output="false" 
		hint="Filter to ensure that there is an instance of the <beanname> object available in the event">
	
	<cffunction name="filterEvent" access="public" output="false" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfscript>
			// set default for <beanname> object
			var bean = "";
			
// Look for an instance of the bean 
			if (arguments.event.isArgDefined("<beanname>")) {
				// don't do anything -- bean already exists in the event
			} else {
				// bean doesn't exist, so create object based on parameters in the event, 
				// setting defaults to "" if the argument doesn't exist
				bean = CreateObject("component", "<appname>.model.<beanname>.<beanname>");
				

//- The bean MUST be initialized here, otherwise the bean itself never gets built properly. Just put the default values here 
<initers>
// Save it in the event for later 			
		arguments.event.setArg("<beanname>", bean);
		}
		</cfscript>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>