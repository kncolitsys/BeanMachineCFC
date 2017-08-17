<!---
	COMPONENT: Header
	AUTHOR: Dave Evartt (davee@wehali.com)
	DATE: 01/23/2008
	PURPOSE: Head file for MyMach2App
	CHANGE HISTORY:
--->
<!--- get the query from the event --->
<cfset RecordSet = event.getArg("BeanTable") />
<!---
 Transpose a query.
 
 @param inputQuery 	 The query to transpose. (Required)
 @param includeHeaders 	 Determines if headers should be included as a column. Defaults to true. (Optional)
 @return Returns a query. 
 @author Glenn Buteau (glenn.buteau@rogers.com) 
 @version 1, August 24, 2005 
--->
<cfset APC = event.getarg("Appconstants")>
<cfset beans = event.getarg("beantable")>

<cfset Dictionary = event.getArg("DictionaryQuery") />
<cfset tablename = event.getArg("tablename") />
<cfset beanname = tablename>


<form action="index.cfm?event=saveDefinition" method="post">

<div id="options">
<div class="box">
	<h3>Options</h3>
	<table>
<cfoutput>	<tr bgcolor="##ffffff"><th align="right">Author:</th><td colspan=2><input type="text" name="beanauthor" size="25" value="Dave Evartt (davee@wehali.com)" /></td>
</tr>
	<tr bgcolor="##ffffff"><th align="right" >Creation Date:</th><td colspan=2><input type="text" name="beanCreationDate" size="25" value="#dateformat(now(),"mm/dd/yyyy")#" /></td>
</tr>
<tr><th colspan=2>DAO/Gateway Methods</th></tr>
	<tr bgcolor="##ffffff"><th  align="right">Create:</th>
	
<td><input type="text" name="CRUDCreateMethod" size="25" value="Create#BeanName#" /></td>

	<tr bgcolor="##ffffff"><th align="right">Read:</th><td colspan=2><input type="text" name="CRUDReadMethod" size="25" value="Read#BeanName#" /></td>
</tr>

	<tr bgcolor="##ffffff"><th  align="right">Update:</th><td colspan=2><input type="text" name="CRUDUpdateMethod" size="25" value="Update#BeanName#" /></td>

</tr>

	<tr bgcolor="##ffffff"><th  align="right">Delete:</th><td colspan=2><input type="text" name="CRUDDeleteMethod" size="25" value="Delete#BeanName#" /></td>

</tr>

	<tr bgcolor="##ffffff"><th  align="right">Gateway:</th><td colspan=2><input type="text" name="GetAllRecordsMethod" size="25" value="Getall#BeanName#Records" /></td>
</cfoutput>
</tr>
</table>
<table><tr valign="top"><td>
<input type="checkbox" name="BuildListener" value="TRUE" checked>Build Listener<br>
<input type="checkbox" name="BuildDAO" value="TRUE" checked>Build DAO<br>
<input type="checkbox" name="BuildGateway" value="TRUE" checked>Build Gateway<br>
<input type="checkbox" name="BuildServices" value="TRUE" checked>Build Services<br>
<input type="checkbox" name="BuildFilter" value="TRUE" checked>Build BeanFilter<br>
<input type="checkbox" name="BuildConfig" value="TRUE" checked>Build Config<br>
<input type="checkbox" name="BuildAppFiles" value="TRUE" checked>Build View Pages<br>&nbsp;
</td></tr>

		<tr>
			<td colspan="8" align="center">
				<input type="button" value="Cancel" 
						onclick="javascript:location.href='index.cfm?event=listDefinitions';" />
				<input type="submit" value="Save it" />
			<input type="submit" name="submit" value="Build it">
			</td>
		</tr>

</table>
</div></div>
<!--- Look for the original CSV file format and warn if loaded --->
<cftry>
<CFLOOP QUERY = "RECORDSET">
  <cfset x = key>
</CFLOOP>
<cfcatch><H4>The  <cfoutput>#tablename#</cfoutput> CSV File is using an old format and needs minor editing. A column indicating if a field is used as a KEY wwas added. Please go into Excel and add a column labeled 'Key' and reload this page. You'll then be able to check off the key field on this page.</h4>
<cfabort>
</cfcatch>
</cftry>


<cfoutput><input type="hidden" name="tablename" value="#tablename#">
<div align="left">

<table border=1>

<th colspan="7" align="center"> Define Bean Characteristics</th></tr>
<tr bgcolor="##ffffff"><th >BeanName:</th><td colspan=6><input type="text" name="NewBeanName" size="45" value="#BeanName#" /></td></tr>


	<tr bgcolor="##ffffff"><th >AppName:</th><td colspan=6><input type="text" name="BeanAppName" size="45" value="#APC.GetBeanAppName()#" /></td></tr>
</cfoutput>


<tr><th>PropertyName</th><th>Key</th><th>DisplayName</th><th>DataType</th><th>Required</th><th>DefaultValue</th><th>Header</th><th>Notes</th></tr>


<cfoutput query="RecordSet">
<tr><td><input type="text" name="PropertyName_#currentrow#" value="#PropertyName#" size="10" ></td>
<td><input type="radio" name="Key" value="#currentrow#" <cfif #key# is 1> checked</cfif> ></td>
<td><input name = "DisplayName_#currentrow#" type="text" value="#DisplayName#" size="10"></td><td>
<select name = "DataType_#currentrow#" >

<cfset datatypes="">
<cfloop query="dictionary">
<cfif recordset.datatype is dictionary.datatypeName  >
<option selected>#datatypename#</option>>
<cfelse>
<option>#datatypename#</option>
</cfif>
</cfloop>



</select></td><td>

<cfif #RequiredFlag# is "1">
    <input type="radio"  checked="checked" name="RequiredFlag_#currentrow#" value="1" />Yes
 <input type="radio"  name="RequiredFlag_#currentrow#" value="0" />No
<cfelse>
    <input type="radio"   name="RequiredFlag_#currentrow#" value="1" />Yes
<input type="radio" checked="checked" name="RequiredFlag_#currentrow#" value="0" />No
</cfif>
<br>


</td><td>
<input name = "DefaultValue_#currentrow#"type="text" value="#DefaultValue#" size="5" maxlength="10"></td>

<td>
<input name = "Header_#currentrow#"type="text" value="#Header#" size="10" maxlength="40"></td><td>
<input name = "Notes_#currentrow#"type="text" value="#Notes#" size="10" maxlength="40"></td></tr>
</CFOUTPUT>


</table>



<cfoutput><input type="hidden" name="BeanCount" value="#recordset.recordcount#"></cfoutput>
</div>
</form>
