<!---
	COMPONENT: users Gateway
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/20/2008
	PURPOSE: usersGateway users bean multirecord methods
	CHANGE HISTORY:
--->
<cfcomponent displayname="users Gateway" hint="I am a data Gataway of the users">

	<cffunction name="init" access="public" returntype="usersGateway" output="false" displayname="users Gatway Constructor" hint="I initialize the users Gateway.">

		<cfargument name="DSN" type="string" required="yes" displayname="Data Source Name" hint="I am the data source to use for persistence." />	
		<cfset variables.DSN = arguments.DSN />

		<cfreturn this />
	</cffunction>

<!--- Get all of the users records in the database --->
<cffunction name="getAllRecords" access="public" output="false" returntype="query" 
			hint="Returns all the users records in the database">
		<!--- var scope the query before running it! --->
		<cfset var resultset = "" />
		
		<!--- run the query and return it --->
		<cfquery name="resultset" datasource="#variables.dsn#">
			SELECT * 
			FROM users
		</cfquery>
		
		<cfreturn resultSet />
	</cffunction>
	
</cfcomponent>

