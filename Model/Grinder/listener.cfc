<!---
	COMPONENT: EmailListner
	AUTHOR: Matt Woodward (mpwoodward@gmail.com)
	DATE: 7/17/2005
	PURPOSE: EmailListener for Mach-II Contact Manager sample application
				* based on ContactManager CFC from original Mach-II Contact Manager sample application
				* combined functionality from ContactManager and RecentContacts CFCs in original application 
					into a single CFC for the updated version of the application
	CHANGE HISTORY:
		* 7/17/2005: component created (Matt Woodward)
--->

<cfcomponent displayname="GrinderListener" output="false" extends="MachII.framework.Listener" 
		hint="GrinderListener">
	<!--- this configure method is called by Mach-II automatically when the application loads --->
	<cffunction name="configure" access="public" output="false" returntype="void" 
			hint="Configures this listener as part of the Mach-II framework">
			
			
	<cfscript>		
			var pm = getAppManager().getPropertyManager();
			// get some constants from the xml file			
			var dsn = pm.getProperty("dsn"); 	
			var Srctemplatepath = expandpath(pm.getProperty("SrcTemplatePath")) & "\"; 	
			var NewBeanPath  = expandpath(pm.getProperty("NewBeanPath")) & "/";
			var CSVpath  = expandpath(pm.getProperty("CSVpath")) & "\";
variables.Libraryservices = createObject("component", "BeanMachine.model.grinder.GrinderServices").init(dsn,Srctemplatepath,NewBeanPath,csvpath);
variables.CSVpath = CSVpath;
variables.newbeanpath = newbeanpath;
		</cfscript>
	</cffunction>
	
	<!--- GATEWAY-RELATED METHODS (gateways deal with *multiple* records) --->
	<!--- get all contacts - returns a query object containing all the contacts --->

<!--- Bean Definition --->

	<cffunction name="SetupBean" access="public" returntype="query" hint="Reads the table and creats a structure of its definition">
 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>
<cfset arguments.event.setArg("tablename",variables.libraryServices.CapFirst(arguments.event.getArg("tablename")))>

<cfreturn variables.libraryServices.SetupBean(arguments.event)>

	</cffunction>

	<cffunction name="SaveDefinition" access="public" output="false" 
			returntype="void" 
			hint="Reads the table and creats a structure of its definition">
 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfset var beans = arrayNew(1)>
<cfset var bean="">
<cfset var beanstruct="">
<cfset var CSVstring = "PropertyName,DisplayName,DataType,RequiredFlag,DefaultValue,header,Notes,Key">



<cfset var CSVFile = "">
 <cfset var crlf = chr(13) & chr(10)>
<cfset var CSVName = "#variables.csvpath##tablename#.csv">
<cfif isdefined ("submit")>
<cfif lcase(left(submit,1)) is "b" >
<!--- User pushed the build button instead of the save button--->
<cfset CreateBean(arguments.event) />
<cfreturn>
</cfif>
</cfif>
<cfloop index="bean" from="1" to="#beancount#">
<cfset beanstruct = structnew()>
<cfset beanstruct.PropertyName = event.getarg("PropertyName_" & bean)>
<cfset beanstruct.datatype = event.getarg("datatype_" & bean)>
<cfset beanstruct.displayname = event.getarg("displayname_" & bean)>
<cfset beanstruct.defaultvalue = event.getarg("defaultvalue_" & bean)>

<cfif event.getarg("key") is bean>
<cfset beanstruct.Key = 1>
<cfelse>
<cfset beanstruct.Key = 0>
</cfif>
<cfset beanstruct.header = event.getarg("header_" & bean)>
<cfset beanstruct.Notes = event.getarg("notes_" & bean)>
<cfset beanstruct.RequiredFlag = event.getarg("RequiredFlag_" & bean)>
<cfdump var = "#beanstruct#">

<!--- Now we have all the data from the form, lets build a CSV file for building the code --->
<cfscript>
csvstring = csvstring & crlf & Beanstruct.propertyname & "," & beanstruct.displayname & "," & beanstruct.datatype & "," & beanstruct.RequiredFlag & "," & beanstruct.defaultvalue & "," & beanstruct.header & "," & beanstruct.Notes  & "," & beanstruct.key;
</cfscript>

</cfloop>


<cfoutput><pre>#csvstring#</pre></cfoutput>

<cffile action="WRITE" file="#CSVname#" output="#csvstring#" addnewline="Yes">
 <cfset announceEvent("showbean", arguments.event.getArgs()) />
<cfreturn >
</cffunction>
	
	
	
	<cffunction name="ListDefinitions" access="public" output="false" 
			returntype="query" 
			hint="Reads the definitions directory and returns an array contents">
 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>
<cfset var ResultQuery="">

<cfdirectory directory="#variables.CSVpath#" action="list" name="ResultQuery" filter="*.csv" recurse="no">
<cfreturn ResultQuery>
</cffunction>

	<cffunction name="ReadTable" access="public" output="false" 
			returntype="query" 
			hint="Reads the table and creats a structure of its definition">
 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfreturn variables.libraryServices.ReadTable(arguments.event)>
	</cffunction>


	<cffunction name="ReadCSV" access="public" output="false" 
			returntype="array" 
			hint="Reads the table and creats a structure of its definition">
 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfreturn variables.libraryServices.ReadCSV(arguments.event)>
	</cffunction>

<!--- creation --->
<cffunction name="CreateBean" access="public" output="false" 
			returntype="void" 
			hint="Creates a new bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>
<cfset var results = structNew()>
<cfset results.bean="Bean:">
<cfset results.listener="Listener:">
<cfset results.DAO="DAO:">
<cfset results.Gateway="Gateway:">
<cfset results.Services="Services:">
<cfset results.BeanerFilter="Bean Filter:">
<cfset results.Config="Config File:">
<cfset results.ViewPages="View Pages:">


<!--- Build the bean --->
<cfset variables.libraryServices.CreateBean(arguments.event)>
<cfset results.bean="Bean: Built!">

<!--- Build the listener --->
<cfif event.getarg("buildListener") is "TRUE">
<cfset variables.libraryServices.CreateListener(arguments.event)>
<cfset results.listener="Listener: Built!">
</cfif>

<!--- Build the DAO --->
<cfif event.getarg("buildDAO") is "TRUE">
<cfset variables.libraryServices.CreateDAO(arguments.event)>
<cfset results.DAO="DAO: Built!">
</cfif>

<!--- Build the Gateway --->
<cfif event.getarg("buildGateway") is "TRUE">
<cfset variables.libraryServices.Creategateway(arguments.event)>
<cfset results.Gateway="Gateway: Built!">
</cfif>

<!--- Build The Services --->
<cfif event.getarg("buildServices") is "TRUE">
<cfset variables.libraryServices.CreateServices(arguments.event)>
<cfset results.Services="Services: stub Built!">
</cfif>

<!--- Build The BeanerFilter --->
<cfif event.getarg("buildFilter") is "TRUE">
<cfset variables.libraryServices.CreateBeanerFilter(arguments.event)>
<cfset results.BeanerFilter="Bean Filter: Built!">
</cfif>

<!--- Build the Config File --->
<cfif event.getarg("buildConfig") is "TRUE">
<cfset variables.libraryServices.CreateConfigFile(arguments.event)>
<cfset results.Config="Config File: Built!">
</cfif>

<!--- Build the View Files --->
<cfif event.getarg("buildAppFiles") is "TRUE">
<cfset variables.libraryServices.CreateViewFiles(arguments.event)>
<cfset results.ViewPages="View Pages: Built!">
</cfif>


<!--- This is just to deal with a late night problem of not being able to return the result 'properly' and trying to get to bed ---> 
<cfset session.buildresults=results>
 <cfset announceEvent("BuildResults", arguments.event.getArgs()) />
<!---  Kill the current event --->

<!---  <cfreturn result> --->
</cffunction>

</cfcomponent>