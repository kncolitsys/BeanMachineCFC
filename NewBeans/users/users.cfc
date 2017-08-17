<!---
	COMPONENT: users
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/20/2008
	PURPOSE: Bean that models the users object
	CHANGE HISTORY:
--->

<!--- This file was built using the Incredible Machii Bean Machine --->
<cfcomponent displayname="users" output="false"
	hint="A bean which models a single users Object.">

	<!--- 	INITIALIZATION / CONFIGURATION 	--->
	<cffunction name="init" access="public" returntype="users" output="false">
<!--- The returntype is how we know it's an users bean --->
	<!--- 	Properties of users	--->
<cfargument name="Company" type="string" required="false" default="" />
<cfargument name="Datecreated" type="string" required="false" default="" />
<cfargument name="Email" type="string" required="false" default="" />
<cfargument name="Firstname" type="string" required="false" default="" />
<cfargument name="Isadmin" type="boolean" required="false" default="false" />
<cfargument name="Lastname" type="string" required="false" default="" />
<cfargument name="Password" type="string" required="false" default="" />
<cfargument name="Userid" type="numeric" required="false" default=0 />
<cfargument name="Username" type="string" required="false" default="" />



<!--- Initialize the users object --->
	<cfset variables.instance = StructNew() />
<cfset setCompany(arguments.Company) />
<cfset setDatecreated(arguments.Datecreated) />
<cfset setEmail(arguments.Email) />
<cfset setFirstname(arguments.Firstname) />
<cfset setIsadmin(arguments.Isadmin) />
<cfset setLastname(arguments.Lastname) />
<cfset setPassword(arguments.Password) />
<cfset setUserid(arguments.Userid) />
<cfset setUsername(arguments.Username) />

		<cfreturn this />
 	</cffunction>

	<!---
	ACCESSORS
	--->
<!-- setter for Company -->
<cffunction name="setCompany" access="public" returntype="void" output="false">
	<cfargument name="Company" type="string" required="true" />
	<cfset variables.instance.Company = arguments.Company />
</cffunction>
<!-- getter for Company -->
<cffunction name="getCompany" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Company />
</cffunction>

<!-- setter for Datecreated -->
<cffunction name="setDatecreated" access="public" returntype="void" output="false">
	<cfargument name="Datecreated" type="string" required="true" />
	<cfset variables.instance.Datecreated = arguments.Datecreated />
</cffunction>
<!-- getter for Datecreated -->
<cffunction name="getDatecreated" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Datecreated />
</cffunction>

<!-- setter for Email -->
<cffunction name="setEmail" access="public" returntype="void" output="false">
	<cfargument name="Email" type="string" required="true" />
	<cfset variables.instance.Email = arguments.Email />
</cffunction>
<!-- getter for Email -->
<cffunction name="getEmail" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Email />
</cffunction>

<!-- setter for Firstname -->
<cffunction name="setFirstname" access="public" returntype="void" output="false">
	<cfargument name="Firstname" type="string" required="true" />
	<cfset variables.instance.Firstname = arguments.Firstname />
</cffunction>
<!-- getter for Firstname -->
<cffunction name="getFirstname" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Firstname />
</cffunction>

<!-- setter for Isadmin -->
<cffunction name="setIsadmin" access="public" returntype="void" output="false">
	<cfargument name="Isadmin" type="boolean" required="true" />
	<cfset variables.instance.Isadmin = arguments.Isadmin />
</cffunction>
<!-- getter for Isadmin -->
<cffunction name="getIsadmin" access="public" returntype="boolean" output="false">
	<cfreturn variables.instance.Isadmin />
</cffunction>

<!-- setter for Lastname -->
<cffunction name="setLastname" access="public" returntype="void" output="false">
	<cfargument name="Lastname" type="string" required="true" />
	<cfset variables.instance.Lastname = arguments.Lastname />
</cffunction>
<!-- getter for Lastname -->
<cffunction name="getLastname" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Lastname />
</cffunction>

<!-- setter for Password -->
<cffunction name="setPassword" access="public" returntype="void" output="false">
	<cfargument name="Password" type="string" required="true" />
	<cfset variables.instance.Password = arguments.Password />
</cffunction>
<!-- getter for Password -->
<cffunction name="getPassword" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Password />
</cffunction>

<!-- setter for Userid -->
<cffunction name="setUserid" access="public" returntype="void" output="false">
	<cfargument name="Userid" type="numeric" required="true" />
	<cfset variables.instance.Userid = arguments.Userid />
</cffunction>
<!-- getter for Userid -->
<cffunction name="getUserid" access="public" returntype="numeric" output="false">
	<cfreturn variables.instance.Userid />
</cffunction>

<!-- setter for Username -->
<cffunction name="setUsername" access="public" returntype="void" output="false">
	<cfargument name="Username" type="string" required="true" />
	<cfset variables.instance.Username = arguments.Username />
</cffunction>
<!-- getter for Username -->
<cffunction name="getUsername" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Username />
</cffunction>

	
</cfcomponent>
