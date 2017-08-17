<!---
	COMPONENT: users Listener
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/20/2008
	PURPOSE: usersListener users bean methods
	CHANGE HISTORY:
--->

<cfcomponent displayname="usersListener" output="false" extends="MachII.framework.Listener" 
		hint="Listener for users beans">
	<!--- this configure method is called by Mach-II automatically when the application loads --->
	<cffunction name="configure" access="public" output="false" returntype="void" 
			hint="Configures this listener as part of the Mach-II framework">
		<!--- We'll need access to our dataobjects (gateway and DAO) in this Listener.  We get the datasource 
 --->
	<cfscript>
			var appConstants = getAppManager().getPropertyManager().getProperty("appConstants");
			var DSN = appConstants.getDSN();
			variables.pm = getAppManager().getPropertyManager();

// Define the service handlers for the listener
		variables.usersGateway = CreateObject("component", "usersGateway").init(DSN);
		variables.usersDAO = CreateObject("component", "usersDAO").init(DSN);
		variables.usersServices = CreateObject("component", "usersServices").init(DSN);
		</cfscript>
		
	</cffunction>
	
<!--- 	CRUD functions --->

		<!--- getEntry - returns a users entry object --->
	<cffunction name="ReadRecord" access="public" output="false" returntype="users" 
		hint="Returns a users object containing a users record">
	<cfargument name="event" type="MachII.framework.Event" required="true" />		

	<!--- Create an empty users object using the bean componant in the same directory.   --->
		<cfset var bean= CreateObject("component", "users").init() />
		<cfset bean.setID(arguments.event.getArg("ID")) />	
		<cfset variables.usersDAO.Read(bean) />
		<!--- return the  bean --->
		<cfreturn bean />
	</cffunction>
	
<!--- update users using event bean --->
	<cffunction name="updateRecord" access="public" output="false" returntype="void" 
			hint="Updates a usersEntry using the users bean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<!--- declare a struct that will hold the results from the call to the DAO to update the record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to update the users." />
		
		<!--- In this case we have the bean already populated with the form data because we used a bean, so just pass it to the update method --->
		<cfset results = variables.usersDAO.update(arguments.event.getArg("users")) />

		<!--- put the message from the results struct in the event object so we can display it to the user at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("usersUpdated", arguments.event.getArgs()) />
	</cffunction>
	

<!--- create entry using event bean --->
	<cffunction name="createRecord" access="public" output="false" returntype="void" 
			hint="Creates a users Record using the users object as an event bean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<!--- declare a struct that will hold the results from the call to the DAO to create a new record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to create the entry." />
		
		<!--- pass the users bean to the DAO's create method --->
		<cfset results = variables.usersDAO.create(arguments.event.getArg("users")) />
		
		<!--- put the message from the results struct in the event object so we can display it to the entry at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("usersCreated", arguments.event.getArgs()) />
	</cffunction>


	<!--- delete user --->
	<cffunction name="deleteRecord" access="public" output="false" returntype="void" 
			hint="Deletes a An entry and announces the next event">
		<cfargument name="event" type="MachII.framework.event" required="true" />
		
		<!--- declare a struct that will hold the results from the call to the DAO to update the record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset var id = arguments.event.getArg("ID") />
		
		<!--- set default results --->
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to delete the entry." />
		
		<!--- pass the users bean to the DAO's delete method --->
		<cfset results = variables.usersDAO.delete(id)/>
		
		<!--- put the message from the results struct in the event object so we can display it
				to the user at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("usersDeleted", arguments.event.getArgs()) />
	</cffunction>

	
<!--- GATEWAY-RELATED METHODS (gateways deal with *multiple* records) --->
<!--- get all users records - returns a query object containing all the records in the users table --->
	<cffunction name="getAllRecords" access="public" output="false" returntype="query" 
			hint="Returns a query object containing all the records">
		<cfreturn variables.usersGateway.getAllRecords() />
	</cffunction>	
</cfcomponent>
