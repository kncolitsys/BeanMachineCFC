<!---
	COMPONENT: <beanname> Gateway
	AUTHOR: <author>
	DATE: <beandate>
	PURPOSE: <beanname>Gateway <beanname> bean multirecord methods
	CHANGE HISTORY:
--->
<cfcomponent displayname="<beanname> Gateway" hint="I am a data Gataway of the <beanname>">

	<cffunction name="init" access="public" returntype="<beanname>Gateway" output="false" displayname="<beanname> Gatway Constructor" hint="I initialize the <beanname> Gateway.">

		<cfargument name="DSN" type="string" required="yes" displayname="Data Source Name" hint="I am the data source to use for persistence." />	
		<cfset variables.DSN = arguments.DSN />

		<cfreturn this />
	</cffunction>

<!--- Get all of the <beanname> records in the database --->
<cffunction name="<GetAllRecordsMethod>" access="public" output="false" returntype="query" 
			hint="Returns all the <beanname> records in the database">
		<!--- var scope the query before running it! --->
		<cfset var resultset = "" />
		
		<!--- run the query and return it --->
		<cfquery name="resultset" datasource="#variables.dsn#">
			SELECT * 
			FROM <tablename>
		</cfquery>
		
		<cfreturn resultSet />
	</cffunction>
	
</cfcomponent>
