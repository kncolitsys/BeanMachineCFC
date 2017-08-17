<cfcomponent displayName="ApplicationConstantsBean" hint="An application constants bean.">
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="applicationConstantsBean" output="false" >
		<cfargument name="dsn" type="string" required="true" />		
		<cfargument name="BeanAppNAme" type="string" required="true" />		
		<cfargument name="SrcTemplatePath" type="string" required="true" />		
		<cfargument name="NewBeanPath" type="string" required="true" />		
		<cfargument name="CSVPath" type="string" required="true" />		
		
		<cfscript>
			variables.instance = structNew();
			setDsn(arguments.dsn);	
			setBeanAppName(arguments.BeanAppName);	
			setSrcTemplatePath(arguments.SrcTemplatePath);	
			setNewBeanPath(arguments.NewBeanPath);	
			setCSVpath(arguments.CSVpath);	
	
		</cfscript>
		<cfreturn this />
	</cffunction>
	
	<!--- GETTERS/SETTERS --->

	<cffunction name="getCSVPath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CSVPath />
	</cffunction>
	
	<cffunction name="setCSVPath" access="public" returntype="void" output="false">
		<cfargument name="CSVPath" type="string" required="true" />
		<cfset variables.instance.CSVPath = arguments.CSVPath />
	</cffunction>
	
	<cffunction name="getdsn" access="public" returntype="string" output="false">
		<cfreturn variables.instance.dsn />
	</cffunction>
	
	<cffunction name="setdsn" access="public" returntype="void" output="false">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.instance.dsn = arguments.dsn />
	</cffunction>
	
	<cffunction name="getBeanAppName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.BeanAppName />
	</cffunction>
	
	<cffunction name="setBeanAppName" access="public" returntype="void" output="false">
		<cfargument name="BeanAppName" type="string" required="true" />
		<cfset variables.instance.BeanAppName = arguments.BeanAppName />
	</cffunction>

	<cffunction name="getSrcTemplatePath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TemplatePath />
	</cffunction>
	
	<cffunction name="setSrcTemplatePath" access="public" returntype="void" output="false">
		<cfargument name="TemplatePath" type="string" required="true" />
		<cfset variables.instance.TemplatePath = arguments.TemplatePath />
	</cffunction>
	
	<cffunction name="getNewBeanPath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.NewBeanPath />
	</cffunction>
	
	<cffunction name="setNewBeanPath" access="public" returntype="void" output="false">
		<cfargument name="NewBeanPath" type="string" required="true" />
		<cfset variables.instance.NewBeanPath = arguments.NewBeanPath />
	</cffunction>

</cfcomponent>