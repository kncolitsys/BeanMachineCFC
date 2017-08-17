<!---
	COMPONENT: users Data Access Object
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/20/2008
	PURPOSE: usersListener users bean CRUD methods
	CHANGE HISTORY:
--->
<cfcomponent displayname="usersDAO" output="false" hint="users DAO">
	<cffunction name="init" access="public" output="false" returntype="usersDAO" hint="Constructor for this CFC">
		<!--- take in the datasource name as an argument and set it to the variables scope so it's available 
				throughout the CFC --->
		<cfargument name="DSN" type="string" required="yes" displayname="Data Source Name" hint="I am the data source to use for persistence." />
		<cfset variables.DSN = arguments.DSN />
	
		<!--- return the object itself --->
		<cfreturn this />
	</cffunction>
	
	<!--- The classic four methods included in a Data Access Object (DAO) are the so-called 'CRUD' methods, 
--->
	<!--- CREATE: creates a new record in the database using the bean passed in This example uses an access database with an autonumber ID. As a result, we fust first create a dummy record, read the record back in to get it's idm before adding the rest of the data, so we do the three step process here. --->
	<cffunction name="create" access="public" output="false" returntype="struct" 
			hint="Creates a new record and returns a struct containing a boolean and a string">
		<cfargument name="Entry" type="users" required="true" />
		
		<!--- var scope everything! --->
		<cfset var insertEntry = "" />
		<cfset var updateEntry = "" />
		<cfset var results = StructNew() />
		<cfset results.success = true />


<cftry>				
<!--- Create the new dummy record --->
<!--- Get the id of the next record --->
	
<cfquery name="GetUserID" datasource="#variables.DSN#">
	SELECT MAX(ID) + 1 AS newid FROM users
</CFQUERY>	

<!--- Store the id in the bean --->
<cfset arguments.entry.setID(getUserID.newid)>



<cfquery name="insertEntry" datasource="#variables.DSN#">
				INSERT INTO users (Company,Datecreated,Email,Firstname,Isadmin,Lastname,Password,Userid,Username
				) VALUES (
				<cfqueryparam value="#arguments.entry.getCompany()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getDatecreated()#" cfsqltype="CF_SQL_TIMESTAMP">,
<cfqueryparam value="#arguments.entry.getEmail()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getFirstname()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getIsadmin()#" cfsqltype="CF_SQL_BIT">,
<cfqueryparam value="#arguments.entry.getLastname()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getPassword()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getUserid()#" cfsqltype="CF_SQL_NUMERIC">,
<cfqueryparam value="#arguments.entry.getUsername()#" cfsqltype="CF_SQL_VARCHAR">
				)
			</cfquery>
<cfset results.message = "The Entry (#getUserID.newid#) was created successfully." />
			<cfcatch type="database">
				<cfset results.success = false />
				<cfset results.message = "A database error occurred: #CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn results />
	</cffunction>
	
	
	
	

	
	<!--- READ: populates a users bean (type in cfargument) using info from the database --->
	<cffunction name="read" access="public" output="false" returntype="void" 
			hint="Populates the Entry bean using the ID of the object passed in">
		<cfargument name="Entry" type="users" required="true" />
		
		<!--- var scope everything! --->
		<cfset var getEntry = "" />

		
		<cfquery name="getEntry" datasource="#variables.DSN#">
			SELECT * 
			FROM users
			WHERE ID = <cfqueryparam value="#arguments.entry.getID()#" cfsqltype="">
		</cfquery>
	
		<!--- if we got a record back, populate the bean --->
		<cfif getEntry.RecordCount EQ 1>

			<cfset arguments.Entry.init(getEntry.Company,getEntry.Datecreated,getEntry.Email,getEntry.Firstname,getEntry.Isadmin,getEntry.Lastname,getEntry.Password,getEntry.Userid,getEntry.Username) />
		</cfif>
	</cffunction>





	
	<!--- UPDATE: updates an existing record in the database using the data in the bean (in type) that's passed in --->
	<cffunction name="update" access="public" output="false" returntype="struct" 
			hint="Updates an existing record in the database and returns a struct containing a boolean and a string">
		<cfargument name="Entry" type="users" required="true" />
		
		<cfset var updateEntry = "" />
		<cfset var results = StructNew() />
		<cfset results.success = true />
		
		<cfset results.message = "The Entry was updated successfully." />
<cftry>
			<cfquery name="updateEntry" datasource="#variables.DSN#">
				UPDATE 	users 
				SET
				Company = <cfqueryparam value="#arguments.entry.getCompany()#" cfsqltype="CF_SQL_VARCHAR">,
Datecreated = <cfqueryparam value="#arguments.entry.getDatecreated()#" cfsqltype="CF_SQL_TIMESTAMP">,
Email = <cfqueryparam value="#arguments.entry.getEmail()#" cfsqltype="CF_SQL_VARCHAR">,
Firstname = <cfqueryparam value="#arguments.entry.getFirstname()#" cfsqltype="CF_SQL_VARCHAR">,
Isadmin = <cfqueryparam value="#arguments.entry.getIsadmin()#" cfsqltype="CF_SQL_BIT">,
Lastname = <cfqueryparam value="#arguments.entry.getLastname()#" cfsqltype="CF_SQL_VARCHAR">,
Password = <cfqueryparam value="#arguments.entry.getPassword()#" cfsqltype="CF_SQL_VARCHAR">,
Userid = <cfqueryparam value="#arguments.entry.getUserid()#" cfsqltype="CF_SQL_NUMERIC">,
Username = <cfqueryparam value="#arguments.entry.getUsername()#" cfsqltype="CF_SQL_VARCHAR">
				
				WHERE ID = <cfqueryparam value="#arguments.entry.getID()#" cfsqltype="">
			</cfquery>

		<cfcatch type="database">
				<cfset results.success = false />
				<cfset results.message = "A database error occurred: #CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		<cfreturn results />
	</cffunction>

	
	<!--- DELETE: deletes a record --->
<!--- 	Unlike the other CRUD methods, the delete function only needs the ID, so that is all that is passed. We could have been consistent and useda bean but why bother? --->
	<cffunction name="delete" access="public" output="false" returntype="struct" 
			hint="Deletes a record and returns a struct containing a boolean and a message">
		<cfargument name="ID" type="numeric" required="no" />
		
		<cfset var deleteEntry = "" />
		<cfset var results = StructNew() />
		<cfset results.success = true />
		<cfset results.message = "Entry (#arguments.id#) was deleted successfully." />
		

		<cftry>
			<cfquery name="deleteEntry" datasource="#variables.DSN#">
				DELETE FROM users 
				WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="">
			</cfquery>
			<cfcatch type="database">
				<cfset results.success = false />
				<cfset results.message = "A database error occurred: #CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn results />
	</cffunction>
</cfcomponent>

