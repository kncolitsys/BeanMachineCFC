<!---
	COMPONENT: users Services
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/20/2008
	PURPOSE: users utility methods
	CHANGE HISTORY:
--->
<cfcomponent displayname="users Services" hint="I am a service of the users">

	<cffunction name="init" access="public" returntype="usersServices" output="false" displayname="users Services Constructor" hint="I initialize the users Services.">

		<cfargument name="DSN" type="string" required="yes" displayname="Data Source Name" hint="I am the data source to use for persistence." />	
		<cfset variables.DSN = arguments.DSN />

		<cfreturn this />
	</cffunction>

	<!--- A sample library function, returns the current date, used as a sample --->
<cffunction name="Today" access="public" returntype="date" hint="Returns a string with thedate in it">
	<cfset var results = dateformat(now(),"mm/dd/yyyy")/>
	<cfreturn results />
</cffunction>

<!--- 
Capitalize the first letter of each word, lowercase the rest
 --->
 
  <cffunction name="CapFirst" access="public" output="false" returntype="string"
			hint="Converts first letter of each word to cap">
	<cfargument name="str" type="string" required="true" />
	<cfset var newstr = "" />
	<cfset var word = "" />
	<cfset var separator = "" />

	<cfloop index="word" list="#arguments.str#" delimiters=" ">
		<cfset newstr = newstr & separator & UCase(left(word,1)) />


		<cfif len(word) gt 1>
			<cfset newstr = newstr & lcase(right(word,len(word)-1)) />
		</cfif>
		<cfset separator = " " />
	</cfloop>

	<cfreturn newstr />
</cffunction>

	
</cfcomponent>

