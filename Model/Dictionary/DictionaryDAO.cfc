<!---
	COMPONENT: Dictionary Data Access Object
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/23/2008
	PURPOSE: DictionaryListener Dictionary bean CRUD methods
	CHANGE HISTORY:
--->
<cfcomponent displayname="DictionaryDAO" output="false" hint="Dictionary DAO">
	<cffunction name="init" access="public" output="false" returntype="DictionaryDAO" hint="Constructor for this CFC">
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
	<cffunction name="CreateDatatype" access="public" output="false" returntype="struct" 
			hint="Creates a new record and returns a struct containing a boolean and a string">
		<cfargument name="Entry" type="Dictionary" required="true" />
		
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
	SELECT MAX(ID) + 1 AS newid FROM dictionary
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
<cfset arguments.entry.setID(newid)>



<cfquery name="insertEntry" datasource="#variables.DSN#">
				INSERT INTO dictionary (Button,SqlDataType,ValidationScript,CfDataType,DataTypeName,Displaylen,Format,ID,InputType,MaxLen,Params
				) VALUES (
				<cfqueryparam value="#arguments.entry.getButton()#" cfsqltype="CF_SQL_LONGVARCHAR">,
<cfqueryparam value="#arguments.entry.getSqlDataType()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getValidationScript()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getCfDataType()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getDataTypeName()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getDisplaylen()#" cfsqltype="CF_SQL_NUMERIC">,
<cfqueryparam value="#arguments.entry.getFormat()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getID()#" cfsqltype="CF_SQL_NUMERIC">,
<cfqueryparam value="#arguments.entry.getInputType()#" cfsqltype="CF_SQL_VARCHAR">,
<cfqueryparam value="#arguments.entry.getMaxLen()#" cfsqltype="CF_SQL_NUMERIC">,
<cfqueryparam value="#arguments.entry.getParams()#" cfsqltype="CF_SQL_LONGVARCHAR">
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
	
	
	
	

	
	<!--- READ: populates a Dictionary bean (type in cfargument) using info from the database --->
	<cffunction name="ReadDatatype" access="public" output="false" returntype="void" 
			hint="Populates the Entry bean using the ID of the object passed in">
		<cfargument name="Entry" type="Dictionary" required="true" />
		
		<!--- var scope everything! --->
		<cfset var getEntry = "" />

		
		<cfquery name="getEntry" datasource="#variables.DSN#">
			SELECT * 
			FROM dictionary
			WHERE ID = <cfqueryparam value="#arguments.entry.getID()#" cfsqltype="CF_SQL_NUMERIC">
		</cfquery>
	
		<!--- if we got a record back, populate the bean --->
		<cfif getEntry.RecordCount EQ 1>

			<cfset arguments.Entry.init(getEntry.Button,getEntry.SqlDataType,getEntry.ValidationScript,getEntry.CfDataType,getEntry.DataTypeName,getEntry.Displaylen,getEntry.Format,getEntry.ID,getEntry.InputType,getEntry.MaxLen,getEntry.Params) />
		</cfif>
	</cffunction>





	
	<!--- UPDATE: updates an existing record in the database using the data in the bean (in type) that's passed in --->
	<cffunction name="UpdateDatatype" access="public" output="false" returntype="struct" 
			hint="Updates an existing record in the database and returns a struct containing a boolean and a string">
		<cfargument name="Entry" type="Dictionary" required="true" />
		
		<cfset var updateEntry = "" />
		<cfset var results = StructNew() />
		<cfset results.success = true />
		
		<cfset results.message = "The Entry was updated successfully." />
<cftry>
			<cfquery name="updateEntry" datasource="#variables.DSN#">
				UPDATE 	dictionary
				SET
				Button = <cfqueryparam value="#arguments.entry.getButton()#" cfsqltype="CF_SQL_LONGVARCHAR">,
SqlDataType = <cfqueryparam value="#arguments.entry.getSqlDataType()#" cfsqltype="CF_SQL_VARCHAR">,
ValidationScript = <cfqueryparam value="#arguments.entry.getValidationScript()#" cfsqltype="CF_SQL_VARCHAR">,
CfDataType = <cfqueryparam value="#arguments.entry.getCfDataType()#" cfsqltype="CF_SQL_VARCHAR">,
DataTypeName = <cfqueryparam value="#arguments.entry.getDataTypeName()#" cfsqltype="CF_SQL_VARCHAR">,
Displaylen = <cfqueryparam value="#arguments.entry.getDisplaylen()#" cfsqltype="CF_SQL_NUMERIC">,
Format = <cfqueryparam value="#arguments.entry.getFormat()#" cfsqltype="CF_SQL_VARCHAR">,
InputType = <cfqueryparam value="#arguments.entry.getInputType()#" cfsqltype="CF_SQL_VARCHAR">,
MaxLen = <cfqueryparam value="#arguments.entry.getMaxLen()#" cfsqltype="CF_SQL_NUMERIC">,
Params = <cfqueryparam value="#arguments.entry.getParams()#" cfsqltype="CF_SQL_LONGVARCHAR">
				
				WHERE ID = <cfqueryparam value="#arguments.entry.getID()#" cfsqltype="CF_SQL_NUMERIC">
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
	<cffunction name="DeleteDatatype" access="public" output="false" returntype="struct" 
			hint="Deletes a record and returns a struct containing a boolean and a message">
		<cfargument name="ID" type="numeric" required="no" />
		
		<cfset var deleteEntry = "" />
		<cfset var results = StructNew() />
		<cfset results.success = true />
		<cfset results.message = "Entry (#arguments.id#) was deleted successfully." />
		

		<cftry>
			<cfquery name="deleteEntry" datasource="#variables.DSN#">
				DELETE FROM dictionary 
				WHERE ID = <cfqueryparam value="#arguments.ID#" cfsqltype="CF_SQL_NUMERIC">
			</cfquery>
			<cfcatch type="database">
				<cfset results.success = false />
				<cfset results.message = "A database error occurred: #CFCATCH.Detail#" />
			</cfcatch>
		</cftry>
		
		<cfreturn results />
	</cffunction>
</cfcomponent>

