<!---
	COMPONENT: Dictionary Listener
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/23/2008
	PURPOSE: DictionaryListener Dictionary bean methods
	CHANGE HISTORY:
--->

<cfcomponent displayname="DictionaryListener" output="false" extends="MachII.framework.Listener" 
		hint="Listener for Dictionary beans">
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
		variables.DictionaryGateway = CreateObject("component", "DictionaryGateway").init(DSN);
		variables.DictionaryDAO = CreateObject("component", "DictionaryDAO").init(DSN);
		variables.DictionaryServices = CreateObject("component", "DictionaryServices").init(DSN);
		</cfscript>
		
	</cffunction>
	
<!--- 	CRUD functions --->

		<!--- getEntry - returns a Dictionary entry object --->
	<cffunction name="ReadDatatype" access="public" output="false" returntype="Dictionary" 
		hint="Returns a Dictionary object containing a Dictionary record">
	<cfargument name="event" type="MachII.framework.Event" required="true" />		

	<!--- Create an empty Dictionary object using the bean componant in the same directory.   --->
		<cfset var bean= CreateObject("component", "Dictionary").init() />
		<cfset bean.setID(arguments.event.getArg("ID")) />	
		<cfset variables.DictionaryDAO.ReadDatatype(bean) />
		<!--- return the  bean --->
		<cfreturn bean />
	</cffunction>
	
<!--- update Dictionary using event bean --->
	<cffunction name="UpdateDatatype" access="public" output="false" returntype="void" 
			hint="Updates a DictionaryEntry using the Dictionary bean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<!--- declare a struct that will hold the results from the call to the DAO to update the record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to update the Dictionary." />
		
		<!--- In this case we have the bean already populated with the form data because we used a bean, so just pass it to the update method --->
		<cfset results = variables.DictionaryDAO.UpdateDatatype(arguments.event.getArg("Dictionary")) />

		<!--- put the message from the results struct in the event object so we can display it to the user at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("DictionaryUpdated", arguments.event.getArgs()) />
	</cffunction>
	

<!--- create entry using event bean --->
	<cffunction name="CreateDatatype" access="public" output="false" returntype="void" 
			hint="Creates a Dictionary Record using the Dictionary object as an event bean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<!--- declare a struct that will hold the results from the call to the DAO to create a new record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to create the entry." />
		
		<!--- pass the Dictionary bean to the DAO's create method --->
		<cfset results = variables.DictionaryDAO.CreateDatatype(arguments.event.getArg("Dictionary")) />
		
		<!--- put the message from the results struct in the event object so we can display it to the entry at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("DictionaryCreated", arguments.event.getArgs()) />
	</cffunction>


	<!--- delete user --->
	<cffunction name="DeleteDatatype" access="public" output="false" returntype="void" 
			hint="Deletes a An entry and announces the next event">
		<cfargument name="event" type="MachII.framework.event" required="true" />
		
		<!--- declare a struct that will hold the results from the call to the DAO to update the record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset var id = arguments.event.getArg("ID") />
		
		<!--- set default results --->
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to delete the entry." />
		
		<!--- pass the Dictionary bean to the DAO's delete method --->
		<cfset results = variables.DictionaryDAO.DeleteDatatype(id)/>
		
		<!--- put the message from the results struct in the event object so we can display it
				to the user at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("DictionaryDeleted", arguments.event.getArgs()) />
	</cffunction>

	
<!--- GATEWAY-RELATED METHODS (gateways deal with *multiple* records) --->
<!--- get all Dictionary records - returns a query object containing all the records in the Dictionary table --->
	<cffunction name="GetallDictionaryRecords" access="public" output="false" returntype="query" 
			hint="Returns a query object containing all the records">
		<cfreturn variables.DictionaryGateway.GetallDictionaryRecords() />
	</cffunction>	
</cfcomponent>
