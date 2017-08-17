<!---
	COMPONENT: <beanname>
	AUTHOR: <author>
	DATE: <beandate>
	PURPOSE: Bean that models the <beanname> object
	CHANGE HISTORY:
--->

<!--- This file was built using the Incredible Machii Bean Machine --->
<cfcomponent displayname="<beanname>" output="false"
	hint="A bean which models a single <beanname> Object.">

	<!--- 	INITIALIZATION / CONFIGURATION 	--->
	<cffunction name="init" access="public" returntype="<beanname>" output="false">
<!--- The returntype is how we know it's an <beanname> bean --->
	<!--- 	Properties of <beanname>	--->
<properties>


<!--- Initialize the <beanname> object --->
	<cfset variables.instance = StructNew() />
<initers>
		<cfreturn this />
 	</cffunction>

<!--- Bean dump method --->

<cffunction name="dump" access="public" returntype="struct" output="false" hint="I return the contents of the bean for debuging">
<cfscript>
var bean = structnew();
<beandump>
</cfscript>
<cfreturn bean>
</cffunction>

	<!---
	ACCESSORS
	--->
<accessors>	
</cfcomponent>