<!---
	COMPONENT: <beanname> Listener
	AUTHOR: <author>
	DATE: <beandate>
	PURPOSE: <beanname>Listener <beanname> bean methods
	CHANGE HISTORY:
--->

<cfcomponent displayname="<beanname>Listener" output="false" extends="MachII.framework.Listener" 
		hint="Listener for <beanname> beans">
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
		variables.<beanname>Gateway = CreateObject("component", "<beanname>Gateway").init(DSN);
		variables.<beanname>DAO = CreateObject("component", "<beanname>DAO").init(DSN);
		variables.<beanname>Services = CreateObject("component", "<beanname>Services").init(DSN);
		</cfscript>
		
	</cffunction>
	
<!--- 	CRUD functions --->

		<!--- getEntry - returns a <beanname> entry object --->
	<cffunction name="<CRUDReadMethod>" access="public" output="false" returntype="<beanname>" 
		hint="Returns a <beanname> object containing a <beanname> record">
	<cfargument name="event" type="MachII.framework.Event" required="true" />		

	<!--- Create an empty <beanname> object using the bean componant in the same directory.   --->
		<cfset var bean= CreateObject("component", "<beanname>").init() />
		<cfset bean.set<BeanIDField>(arguments.event.getArg("<BeanIDField>")) />	
		<cfset variables.<beanname>DAO.<CRUDReadMethod>(bean) />
		<!--- return the  bean --->
		<cfreturn bean />
	</cffunction>
	
<!--- update <beanname> using event bean --->
	<cffunction name="<CRUDUpdateMethod>" access="public" output="false" returntype="void" 
			hint="Updates a <beanname>Entry using the <beanname> bean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<!--- declare a struct that will hold the results from the call to the DAO to update the record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to update the <beanname>." />
		
		<!--- In this case we have the bean already populated with the form data because we used a bean, so just pass it to the update method --->
		<cfset results = variables.<beanname>DAO.<CRUDUpdateMethod>(arguments.event.getArg("<beanname>")) />

		<!--- put the message from the results struct in the event object so we can display it to the user at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("<beanname>Updated", arguments.event.getArgs()) />
	</cffunction>
	

<!--- create entry using event bean --->
	<cffunction name="<CRUDCreateMethod>" access="public" output="false" returntype="void" 
			hint="Creates a <beanname> Record using the <beanname> object as an event bean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<!--- declare a struct that will hold the results from the call to the DAO to create a new record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to create the entry." />
		
		<!--- pass the <beanname> bean to the DAO's create method --->
		<cfset results = variables.<beanname>DAO.<CRUDCreateMethod>(arguments.event.getArg("<beanname>")) />
		
		<!--- put the message from the results struct in the event object so we can display it to the entry at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("<beanname>Created", arguments.event.getArgs()) />
	</cffunction>


	<!--- delete user --->
	<cffunction name="<CRUDDeleteMethod>" access="public" output="false" returntype="void" 
			hint="Deletes a An entry and announces the next event">
		<cfargument name="event" type="MachII.framework.event" required="true" />
		
		<!--- declare a struct that will hold the results from the call to the DAO to update the record, and set default values for the struct's contents --->
		<cfset var results = StructNew() />
		<cfset var id = arguments.event.getArg("<beanIDfield>") />
		
		<!--- set default results --->
		<cfset results.success = false />
		<cfset results.message = "An error occurred while attempting to delete the entry." />
		
		<!--- pass the <beanname> bean to the DAO's delete method --->
		<cfset results = variables.<beanname>DAO.<CRUDDeleteMethod>(id)/>
		
		<!--- put the message from the results struct in the event object so we can display it
				to the user at the end of the next event --->
		<cfset arguments.event.setArg("message", results.message) />
		
		<!--- announce the next event --->
		<cfset announceEvent("<beanname>Deleted", arguments.event.getArgs()) />
	</cffunction>

	
<!--- GATEWAY-RELATED METHODS (gateways deal with *multiple* records) --->
<!--- get all <beanname> records - returns a query object containing all the records in the <tablename> table --->
	<cffunction name="<GetAllRecordsMethod>" access="public" output="false" returntype="query" 
			hint="Returns a query object containing all the records">
		<cfreturn variables.<beanname>Gateway.<GetAllRecordsMethod>() />
	</cffunction>	
</cfcomponent>