<cfset users = event.getArg("users") />

<cfoutput>
<form action="index.cfm?event=#event.getArg('submitEvent')#" method="post">
	<table border="0" width="500" cellpadding="2" cellspacing="1" bgcolor="##999999">


 		<tr><th align="right">Company:</th><td><input type="text"  name="Company" size="30" value="#users.getCompany()#" /></td>
		</tr>
 		<tr><th align="right">Datecreated:</th><td><input type="text"  name="Datecreated" size="30" value="#users.getDatecreated()#" /></td>
		</tr>
 		<tr><th align="right">Email:</th><td><input type="text"  name="Email" size="30" value="#users.getEmail()#" /></td>
		</tr>
 		<tr><th align="right">Firstname:</th><td><input type="text"  name="Firstname" size="30" value="#users.getFirstname()#" /></td>
		</tr>
 		<tr><th align="right">Isadmin:</th><td><input type="text"  name="Isadmin" size="30" value="#users.getIsadmin()#" /></td>
		</tr>
 		<tr><th align="right">Lastname:</th><td><input type="text"  name="Lastname" size="30" value="#users.getLastname()#" /></td>
		</tr>
 		<tr><th align="right">Password:</th><td><input type="text"  name="Password" size="30" value="#users.getPassword()#" /></td>
		</tr>
 		<tr><th align="right">Userid:</th><td><input type="text"  name="Userid" size="30" value="#users.getUserid()#" /></td>
		</tr>
 		<tr><th align="right">Username:</th><td><input type="text"  name="Username" size="30" value="#users.getUsername()#" /></td>
		</tr>

		<tr>
			<td colspan="2" align="center">
				<input type="button" value="Cancel" 
						onclick="javascript:location.href='index.cfm?event=listusers';" />
				<input type="submit" value="#event.getArg('submitLabel', '')#" />
			</td>
		</tr>

	</table>
	

	
	<!-- need these if there's an error with the required fields so they'll be available in the next event -->
	<input type="hidden" name="submitEvent" value="#event.getArg('submitEvent')#" />
	<input type="hidden" name="submitLabel" value="#event.getArg('submitLabel')#" />
</form>
</cfoutput>

