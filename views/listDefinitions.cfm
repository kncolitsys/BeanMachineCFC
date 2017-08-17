<!---
	COMPONENT: Header
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/23/2008
	PURPOSE: Head file for MyMach2App
	CHANGE HISTORY:
--->
<!--- get the query from the event --->
<cfset RecordSet = event.getArg("QueryResults") />

<cfif RecordSet.recordcount is not 0>
<!--- End of Lookup, Display the words found --->
<div align="center">
<table border=1>
<tr>
<th>Bean name</th><th>Actions</th></tr>
<cfoutput query="RecordSet">
<cfset beanname = listtoarray(name,".")>
<cfif lcase(beanname[1]) is not "template">
<tr>
<td>#BeanName[1]#</td><td><a href="index.cfm?event=StartBean&&beansource=csvfile&tablename=#BeanNAME[1]#">Build Bean</a></td>
</tr>
</cfif></CFOUTPUT>
</table>
</div>

<cfelse>
<div align="center"><font size="+2">
Sorry, There are no definitions.
</font></div>	


</cfif>

