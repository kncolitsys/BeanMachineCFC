<!---
	COMPONENT: usersBeanerFilter
	AUTHOR:Dave Evartt (davee@wehali.com)
	DATE: 01/20/2008
	PURPOSE: This filter makes sure an instance of the <benaname> bean is available in the event.
	CHANGE HISTORY:
--->

<cfcomponent display="usersBeanerFilter" extends="MachII.framework.EventFilter" output="false" 
		hint="Filter to ensure that there is an instance of the users object available in the event">
	
	<cffunction name="filterEvent" access="public" output="false" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfscript>
			// set default for users object
			var bean = "";
			
// Look for an instance of the bean 
			if (arguments.event.isArgDefined("users")) {
				// don't do anything -- bean already exists in the event
			} else {
				// bean doesn't exist, so create object based on parameters in the event, 
				// setting defaults to "" if the argument doesn't exist
				bean = CreateObject("component", "MyMach2App.model.users.users");
				

//- The bean MUST be initialized here, otherwise the bean itself never gets built properly. Just put the default values here 
bean.setCompany(arguments.event.getArg("Company", ""));
bean.setDatecreated(arguments.event.getArg("Datecreated", ""));
bean.setEmail(arguments.event.getArg("Email", ""));
bean.setFirstname(arguments.event.getArg("Firstname", ""));
bean.setIsadmin(arguments.event.getArg("Isadmin", "false"));
bean.setLastname(arguments.event.getArg("Lastname", ""));
bean.setPassword(arguments.event.getArg("Password", ""));
bean.setUserid(arguments.event.getArg("Userid", 0));
bean.setUsername(arguments.event.getArg("Username", ""));

// Save it in the event for later 			
		arguments.event.setArg("users", bean);
		}
		</cfscript>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>
