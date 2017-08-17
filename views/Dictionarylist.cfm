<!---
	COMPONENT: Header
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/23/2008
	PURPOSE: Head file for MyMach2App
	CHANGE HISTORY:
--->
<!--- get the query from the event --->
<cfset DictionaryRecordSet = event.getArg("QueryResults") />

<cfif DictionaryRecordSet.recordcount is not 0>
<!--- End of Lookup, Display the words found --->
<div align="center">
<table border=1>
<tr>
<th>DataTypeName</th><th>CfDataType</th><th>SqlDataType</th><th>InputType</th><th>ValidationScript</th><th>Displaylen</th><th>MaxLen</th><th>Params</th><th>Button</th><th>Actions</th></tr>
<cfoutput query="DictionaryRecordSet">
<tr>
<td>#DataTypeName#</td><td>#CfDataType#</td><td>#SqlDataType#</td><td>#InputType#</td><td>#ValidationScript#</td><td>#Displaylen#</td><td>#MaxLen#</td><td>
<cfif params is not "">
#left(params, 5)#...</cfif>
</td><td><cfif button is not "">...</cfif>
</td><td><a href="index.cfm?event=EditDictionary&ID=#ID#">EDIT</a> | <a href="index.cfm?event=DeleteDictionary&ID=#ID#">DELETE</a></td>
</tr>
</CFOUTPUT>
</table>
</div>

<cfelse>
<div align="center"><font size="+2">
Sorry, The Dictionary table is empty.
</font></div>	


</cfif>

