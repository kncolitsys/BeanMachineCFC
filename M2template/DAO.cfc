<!---
	COMPONENT: <beanname> Data Access Object
	AUTHOR: <author>
	DATE: <beandate>
	PURPOSE: <beanname>Listener <beanname> bean CRUD methods
	CHANGE HISTORY:
--->
<cfcomponent displayname="<beanname>DAO" output="false" hint="<beanname> DAO">
	<cffunction name="init" access="public" output="false" returntype="<beanName>DAO" hint="Constructor for this CFC">
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
	<cffunction name="<CRUDcreateMethod>" access="public" output="false" returntype="struct" 
			hint="Creates a new record and returns a struct containing a boolean and a string">
		<cfargument name="Entry" type="<beanname>" required="true" />
		
		<!--- var scope everything! --->
		<cfset var insertEntry = "" />
		<cfset var updateEntry = "" />
		<cfset var results = StructNew() />

		<cfset var getNewID = "">
		<cfset var NewID = "">
		<cfset results.success = true />
<cftry>				
<!--- Create the new dummy record --->
<!--- Get the id of the next record --->
<cftry>
<cfquery name="GetNewID" datasource="#variables.DSN#">
	SELECT MAX(<BeanIDfield>) + 1 AS newid FROM <tablename>
</CFQUERY>	
<cfset newid=getNewID.newid>

<cfcatch>
<!--- Must be an empty table --->
<cfset NewID = "1">
</cfcatch>
</cftry>

<cfif newid is "">
<cfset NewID = "1">
</cfif>
<!--- Store the id in the bean --->
<cfset arguments.entry.set<BeanIDfield>(newid)>



<cfquery name="insertEntry" datasource="#variables.DSN#">
				INSERT INTO <tablename> (<beanfields>
				) VALUES (
				<beanfieldInserts>
				)
			</cfquery>
<cfset results.message = "The Entry (#newid#) was created successfully." />
			<cfcatch type="database">
				<cfset results.success = false />
				<cfset results.message = "A database error occurred: #CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn results />
	</cffunction>
	
	
	
	

	
	<!--- READ: populates a <beanname> bean (type in cfargument) using info from the database --->
	<cffunction name="<CRUDreadMethod>" access="public" output="false" returntype="void" 
			hint="Populates the Entry bean using the ID of the object passed in">
		<cfargument name="Entry" type="<beanname>" required="true" />
		
		<!--- var scope everything! --->
		<cfset var getEntry = "" />

		
		<cfquery name="getEntry" datasource="#variables.DSN#">
			SELECT * 
			FROM <tablename>
			WHERE <beanIDfield> = <cfqueryparam value="#arguments.entry.get<BeanIDField>()#" cfsqltype="<beanIDType>">
		</cfquery>
	
		<!--- if we got a record back, populate the bean --->
		<cfif getEntry.RecordCount EQ 1>

			<cfset arguments.Entry.init(<beanEntryfields>) />
		</cfif>
	</cffunction>





	
	<!--- UPDATE: updates an existing record in the database using the data in the bean (in type) that's passed in --->
	<cffunction name="<CRUDUpdateMethod>" access="public" output="false" returntype="struct" 
			hint="Updates an existing record in the database and returns a struct containing a boolean and a string">
		<cfargument name="Entry" type="<beanname>" required="true" />
		
		<cfset var updateEntry = "" />
		<cfset var results = StructNew() />
		<cfset results.success = true />
		
		<cfset results.message = "The Entry was updated successfully." />
<cftry>
			<cfquery name="updateEntry" datasource="#variables.DSN#">
				UPDATE 	<tablename> 
				SET
				<beanfieldUpdates>
				
				WHERE <beanIDfield> = <cfqueryparam value="#arguments.entry.get<BeanIDField>()#" cfsqltype="<beanIDType>">
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
	<cffunction name="<CRUDdeleteMethod>" access="public" output="false" returntype="struct" 
			hint="Deletes a record and returns a struct containing a boolean and a message">
		<cfargument name="ID" type="numeric" required="no" />
		
		<cfset var deleteEntry = "" />
		<cfset var results = StructNew() />
		<cfset results.success = true />
		<cfset results.message = "Entry (#arguments.id#) was deleted successfully." />
		

		<cftry>
			<cfquery name="deleteEntry" datasource="#variables.DSN#">
				DELETE FROM <tablename> 
				WHERE <beanIDfield> = <cfqueryparam value="#arguments.ID#" cfsqltype="<beanIDType>">
			</cfquery>
			<cfcatch type="database">
				<cfset results.success = false />
				<cfset results.message = "A database error occurred: #CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn results />
	</cffunction>
</cfcomponent>
