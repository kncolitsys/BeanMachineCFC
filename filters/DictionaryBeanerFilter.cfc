<!---
	COMPONENT: DictionaryBeanerFilter
	AUTHOR:Dave Evartt (davee@wehali.com)
	DATE: 01/23/2008
	PURPOSE: This filter makes sure an instance of the <benaname> bean is available in the event.
	CHANGE HISTORY:
--->

<cfcomponent display="DictionaryBeanerFilter" extends="MachII.framework.EventFilter" output="false" 
		hint="Filter to ensure that there is an instance of the Dictionary object available in the event">
	
	<cffunction name="filterEvent" access="public" output="false" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfscript>
			// set default for Dictionary object
			var bean = "";
			
// Look for an instance of the bean 
			if (arguments.event.isArgDefined("Dictionary")) {
				// don't do anything -- bean already exists in the event
			} else {
				// bean doesn't exist, so create object based on parameters in the event, 
				// setting defaults to "" if the argument doesn't exist
				bean = CreateObject("component", "BeanMachine.model.Dictionary.Dictionary");
				

//- The bean MUST be initialized here, otherwise the bean itself never gets built properly. Just put the default values here 
bean.setButton(arguments.event.getArg("Button", ""));
bean.setSqlDataType(arguments.event.getArg("SqlDataType", ""));
bean.setValidationScript(arguments.event.getArg("ValidationScript", ""));
bean.setCfDataType(arguments.event.getArg("CfDataType", ""));
bean.setDataTypeName(arguments.event.getArg("DataTypeName", ""));
bean.setDisplaylen(arguments.event.getArg("Displaylen", 0));
bean.setFormat(arguments.event.getArg("Format", ""));
bean.setID(arguments.event.getArg("ID", 0));
bean.setInputType(arguments.event.getArg("InputType", ""));
bean.setMaxLen(arguments.event.getArg("MaxLen", 0));
bean.setParams(arguments.event.getArg("Params", ""));

// Save it in the event for later 			
		arguments.event.setArg("Dictionary", bean);
		}
		</cfscript>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>
