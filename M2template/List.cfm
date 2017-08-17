<!---
	COMPONENT: Header
	AUTHOR: <author>
	DATE: <beandate>
	PURPOSE: Head file for <appname>
	CHANGE HISTORY:
--->
<!--- get the query from the event --->
<cfset <beanName>RecordSet = event.getArg("QueryResults") />

<cfif <beanName>RecordSet.recordcount is not 0>
<!--- End of Lookup, Display the words found --->

<div align="center"><table border=1>
<headers>
<cfoutput query="<beanName>RecordSet">
<tr>
<beanListfields>
</tr>
</CFOUTPUT>
</table>
</div>

<cfelse>
<div align="center"><font size="+2">
Sorry, That word was not found in the RecordSet
</font></div>	


</cfif>
