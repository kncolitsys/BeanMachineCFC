<!---
	COMPONENT: Dictionary Gateway
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/23/2008
	PURPOSE: DictionaryGateway Dictionary bean multirecord methods
	CHANGE HISTORY:
--->
<cfcomponent displayname="Dictionary Gateway" hint="I am a data Gataway of the Dictionary">

	<cffunction name="init" access="public" returntype="DictionaryGateway" output="false" displayname="Dictionary Gatway Constructor" hint="I initialize the Dictionary Gateway.">

		<cfargument name="DSN" type="string" required="yes" displayname="Data Source Name" hint="I am the data source to use for persistence." />	
		<cfset variables.DSN = arguments.DSN />

		<cfreturn this />
	</cffunction>

<!--- Get all of the Dictionary records in the database --->
<cffunction name="GetallDictionaryRecords" access="public" output="false" returntype="query" 
			hint="Returns all the Dictionary records in the database">
		<!--- var scope the query before running it! --->
		<cfset var resultset = "" />
		
		<!--- run the query and return it --->

		<cfquery name="resultset" datasource="#variables.dsn#">
			SELECT * 
			FROM dictionary
			Order by DataTypeName
		</cfquery>
		
		<cfreturn resultSet />
	</cffunction>
	
</cfcomponent>

