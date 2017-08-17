<!---
	COMPONENT: Header
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/20/2008
	PURPOSE: Head file for MyMach2App
	CHANGE HISTORY:
--->
<!--- get the query from the event --->
<cfset usersRecordSet = event.getArg("QueryResults") />

<cfif usersRecordSet.recordcount is not 0>
<!--- End of Lookup, Display the words found --->

<div align="center"><table border=1>
<tr><th>Company</th><th>Datecreated</th><th>Email</th><th>Firstname</th><th>Isadmin</th><th>Lastname</th><th>Password</th><th>Userid</th><th>Username</th><th>Actions</th></tr>
<cfoutput query="usersRecordSet">
<tr>
<td>#Company#</td><td>#Datecreated#</td><td>#Email#</td><td>#Firstname#</td><td>#Isadmin#</td><td>#Lastname#</td><td>#Password#</td><td>#Userid#</td><td>#Username#</td><td><a href="index.cfm?event=Editusers&ID=#ID#">EDIT</a> \ <a href="index.cfm?event=Deleteusers&ID=#ID#">DELETE</a></td>
</tr>
</CFOUTPUT>
</table>
</div>

<cfelse>
<div align="center"><font size="+2">
Sorry, That word was not found in the RecordSet
</font></div>	


</cfif>

