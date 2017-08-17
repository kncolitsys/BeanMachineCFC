<cfset Dictionary = event.getArg("Dictionary") />


<cfoutput>
<form action="index.cfm?event=#event.getArg('submitEvent')#" method="post">
	<table border="0" width="500" cellpadding="2" cellspacing="1" bgcolor="##999999">
 		<tr><th align="right">ID:</th><td><input type="text"  name="ID" size="30" value="#Dictionary.getID()#" /></td>
		</tr>
 		<tr><th align="right">DataTypeName:</th><td><input type="text"  name="DataTypeName" size="30" value="#Dictionary.getDataTypeName()#" /></td>
		</tr>
 
 		<tr><th align="right">CfDataType:</th><td><input type="text"  name="CfDataType" size="30" value="#Dictionary.getCfDataType()#" /></td>
		</tr>
		</tr>
 		<tr><th align="right">SqlDataType:</th><td><input type="text"  name="SqlDataType" size="30" value="#Dictionary.getSqlDataType()#" /></td>
		</tr>
		
 		<tr><th align="right">InputType:</th><td><input type="text"  name="InputType" size="30" value="#Dictionary.getInputType()#" /></td>
		</tr>
		
		<tr><th align="right">Displaylen:</th><td><input type="text"  name="Displaylen" size="30" value="#Dictionary.getDisplaylen()#" /></td>
		</tr>
 		<tr><th align="right">MaxLen:</th><td><input type="text"  name="MaxLen" size="30" value="#Dictionary.getMaxLen()#" /></td>
		</tr>	
			
 		<tr><th align="right">Format:</th><td><input type="text"  name="Format" size="30" value="#Dictionary.getFormat()#" /></td>
		</tr>
 		<tr><th align="right">ValidationScript:</th><td><input type="text"  name="ValidationScript" size="30" value="#Dictionary.getValidationScript()#" /></td>
		</tr>
		
		<tr valign="top"><th align="right">Button:</th><td><textarea cols="50" rows="5" name="Button">#Dictionary.getButton()#</textarea></td>
		</tr>




 		<tr valign="top"><th align="right">Params:</th><td><textarea cols="50" rows="5"   name="Params" >#Dictionary.getParams()#</textarea></td>
		</tr>

		<tr>
			<td colspan="2" align="center">
				<input type="button" value="Cancel" 
						onclick="javascript:location.href='index.cfm?event=listDictionary';" />
				<input type="submit" value="#event.getArg('submitLabel', '')#" />
			</td>
		</tr>

	</table>
	

	
	<!-- need these if there's an error with the required fields so they'll be available in the next event -->
	<input type="hidden" name="submitEvent" value="#event.getArg('submitEvent')#" />
	<input type="hidden" name="submitLabel" value="#event.getArg('submitLabel')#" />
</form>
</cfoutput>

