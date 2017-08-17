<!---
	COMPONENT: UsersBeanerFilter
	AUTHOR:Dave Evartt (davee@wehali.com)
	DATE: 01/22/2008
	PURPOSE: This filter makes sure an instance of the <benaname> bean is available in the event.
	CHANGE HISTORY:
--->

<cfcomponent display="UsersBeanerFilter" extends="MachII.framework.EventFilter" output="false" 
		hint="Filter to ensure that there is an instance of the Users object available in the event">
	
	<cffunction name="filterEvent" access="public" output="false" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfscript>
			// set default for Users object
			var bean = "";
			
// Look for an instance of the bean 
			if (arguments.event.isArgDefined("Users")) {
				// don't do anything -- bean already exists in the event
			} else {
				// bean doesn't exist, so create object based on parameters in the event, 
				// setting defaults to "" if the argument doesn't exist
				bean = CreateObject("component", "MyMach2App.model.Users.Users");
				

//- The bean MUST be initialized here, otherwise the bean itself never gets built properly. Just put the default values here 
bean.setCompany(arguments.event.getArg("Company", ""));
bean.setdateCreated(arguments.event.getArg("dateCreated", ""));
bean.setemail(arguments.event.getArg("email", ""));
bean.setfirstName(arguments.event.getArg("firstName", ""));
bean.setisAdmin(arguments.event.getArg("isAdmin", "FALSE"));
bean.setlastName(arguments.event.getArg("lastName", ""));
bean.setpassword(arguments.event.getArg("password", ""));
bean.setuserID(arguments.event.getArg("userID", 0));
bean.setusername(arguments.event.getArg("username", ""));

// Save it in the event for later 			
		arguments.event.setArg("Users", bean);
		}
		</cfscript>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>
