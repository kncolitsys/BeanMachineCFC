<cfset <beanname> = event.getArg("<beanname>") />

<cfoutput>
<form action="index.cfm?event=#event.getArg('submitEvent')#" method="post" onSubmit="return Validate();">
	<table border="0" width="500" cellpadding="2" cellspacing="1" bgcolor="##999999">

<BeanFormFields>

		<tr>
			<td colspan="2" align="center">
				<input type="button" value="Cancel" 
						onclick="javascript:location.href='index.cfm?event=list<beanname>';" />
				<input type="submit" value="#event.getArg('submitLabel', '')#" />
			</td>
		</tr>

	</table>
	

	
	<!-- need these if there's an error with the required fields so they'll be available in the next event -->
	<input type="hidden" name="submitEvent" value="#event.getArg('submitEvent')#" />
	<input type="hidden" name="submitLabel" value="#event.getArg('submitLabel')#" />
</form>
</cfoutput>
