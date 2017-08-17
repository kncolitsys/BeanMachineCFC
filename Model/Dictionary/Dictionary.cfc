<!---
	COMPONENT: Dictionary
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/23/2008
	PURPOSE: Bean that models the Dictionary object
	CHANGE HISTORY:
--->

<!--- This file was built using the Incredible Machii Bean Machine --->
<cfcomponent displayname="Dictionary" output="false"
	hint="A bean which models a single Dictionary Object.">

	<!--- 	INITIALIZATION / CONFIGURATION 	--->
	<cffunction name="init" access="public" returntype="Dictionary" output="false">
<!--- The returntype is how we know it's an Dictionary bean --->
	<!--- 	Properties of Dictionary--->
<cfargument name="Button" type="string" required="false" default="" />
<cfargument name="SqlDataType" type="string" required="false" default="" />
<cfargument name="ValidationScript" type="string" required="false" default="" />
<cfargument name="CfDataType" type="string" required="false" default="" />
<cfargument name="DataTypeName" type="string" required="false" default="" />
<cfargument name="Displaylen" type="numeric" required="false" default=0 />
<cfargument name="Format" type="string" required="false" default="" />
<cfargument name="ID" type="numeric" required="false" default=0 />
<cfargument name="InputType" type="string" required="false" default="" />
<cfargument name="MaxLen" type="numeric" required="false" default=0 />
<cfargument name="Params" type="string" required="false" default="" />



<!--- Initialize the Dictionary object --->
	<cfset variables.instance = StructNew() />
<cfset setButton(arguments.Button) />
<cfset setSqlDataType(arguments.SqlDataType) />
<cfset setValidationScript(arguments.ValidationScript) />
<cfset setCfDataType(arguments.CfDataType) />
<cfset setDataTypeName(arguments.DataTypeName) />
<cfset setDisplaylen(arguments.Displaylen) />
<cfset setFormat(arguments.Format) />
<cfset setID(arguments.ID) />
<cfset setInputType(arguments.InputType) />
<cfset setMaxLen(arguments.MaxLen) />
<cfset setParams(arguments.Params) />

		<cfreturn this />
 	</cffunction>

<cffunction name="dump" access="public" returntype="struct" output="false">
<cfscript>
var bean = structnew();
bean.beanname="dictionary";
bean.button=getButton() ;
bean.sqldatatype=getSqlDataType() ;
bean.validationscript=getValidationScript() ;
bean.cfdatatype=getCfDataType() ;
bean.datatypename=getDataTypeName() ;
bean.displaylen=getDisplaylen() ;
bean.format=getFormat() ;
bean.id=getID() ;
bean.inputtype=getInputType() ;
bean.maxlen=getMaxLen() ;
bean.param=getParams() ;


</cfscript>
<cfreturn bean>
</cffunction>

	<!---
	ACCESSORS
	
	
	--->
<!-- setter for Button -->
<cffunction name="setButton" access="public" returntype="void" output="false">
	<cfargument name="Button" type="string" required="true" />
	<cfset variables.instance.Button = arguments.Button />
</cffunction>
<!-- getter for Button -->
<cffunction name="getButton" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Button />
</cffunction>

<!-- setter for SqlDataType -->
<cffunction name="setSqlDataType" access="public" returntype="void" output="false">
	<cfargument name="SqlDataType" type="string" required="true" />
	<cfset variables.instance.SqlDataType = arguments.SqlDataType />
</cffunction>
<!-- getter for SqlDataType -->
<cffunction name="getSqlDataType" access="public" returntype="string" output="false">
	<cfreturn variables.instance.SqlDataType />
</cffunction>

<!-- setter for ValidationScript -->
<cffunction name="setValidationScript" access="public" returntype="void" output="false">
	<cfargument name="ValidationScript" type="string" required="true" />
	<cfset variables.instance.ValidationScript = arguments.ValidationScript />
</cffunction>
<!-- getter for ValidationScript -->
<cffunction name="getValidationScript" access="public" returntype="string" output="false">
	<cfreturn variables.instance.ValidationScript />
</cffunction>

<!-- setter for CfDataType -->
<cffunction name="setCfDataType" access="public" returntype="void" output="false">
	<cfargument name="CfDataType" type="string" required="true" />
	<cfset variables.instance.CfDataType = arguments.CfDataType />
</cffunction>
<!-- getter for CfDataType -->
<cffunction name="getCfDataType" access="public" returntype="string" output="false">
	<cfreturn variables.instance.CfDataType />
</cffunction>

<!-- setter for DataTypeName -->
<cffunction name="setDataTypeName" access="public" returntype="void" output="false">
	<cfargument name="DataTypeName" type="string" required="true" />
	<cfset variables.instance.DataTypeName = arguments.DataTypeName />
</cffunction>
<!-- getter for DataTypeName -->
<cffunction name="getDataTypeName" access="public" returntype="string" output="false">
	<cfreturn variables.instance.DataTypeName />
</cffunction>

<!-- setter for Displaylen -->
<cffunction name="setDisplaylen" access="public" returntype="void" output="false">
	<cfargument name="Displaylen" type="numeric" required="true" />
	<cfset variables.instance.Displaylen = arguments.Displaylen />
</cffunction>
<!-- getter for Displaylen -->
<cffunction name="getDisplaylen" access="public" returntype="numeric" output="false">
	<cfreturn variables.instance.Displaylen />
</cffunction>

<!-- setter for Format -->
<cffunction name="setFormat" access="public" returntype="void" output="false">
	<cfargument name="Format" type="string" required="true" />
	<cfset variables.instance.Format = arguments.Format />
</cffunction>
<!-- getter for Format -->
<cffunction name="getFormat" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Format />
</cffunction>

<!-- setter for ID -->
<cffunction name="setID" access="public" returntype="void" output="false">
	<cfargument name="ID" type="numeric" required="true" />
	<cfset variables.instance.ID = arguments.ID />
</cffunction>
<!-- getter for ID -->
<cffunction name="getID" access="public" returntype="numeric" output="false">
	<cfreturn variables.instance.ID />
</cffunction>

<!-- setter for InputType -->
<cffunction name="setInputType" access="public" returntype="void" output="false">
	<cfargument name="InputType" type="string" required="true" />
	<cfset variables.instance.InputType = arguments.InputType />
</cffunction>
<!-- getter for InputType -->
<cffunction name="getInputType" access="public" returntype="string" output="false">
	<cfreturn variables.instance.InputType />
</cffunction>

<!-- setter for MaxLen -->
<cffunction name="setMaxLen" access="public" returntype="void" output="false">
	<cfargument name="MaxLen" type="numeric" required="true" />
	<cfset variables.instance.MaxLen = arguments.MaxLen />
</cffunction>
<!-- getter for MaxLen -->
<cffunction name="getMaxLen" access="public" returntype="numeric" output="false">
	<cfreturn variables.instance.MaxLen />
</cffunction>

<!-- setter for Params -->
<cffunction name="setParams" access="public" returntype="void" output="false">
	<cfargument name="Params" type="string" required="true" />
	<cfset variables.instance.Params = arguments.Params />
</cffunction>
<!-- getter for Params -->
<cffunction name="getParams" access="public" returntype="string" output="false">
	<cfreturn variables.instance.Params />
</cffunction>

	
</cfcomponent>
