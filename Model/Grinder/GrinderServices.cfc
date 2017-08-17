<cfcomponent displayname="GrinderServices" output="false" hint="GrinderServices">
	<cffunction name="init" access="public" output="false" returntype="GrinderServices" hint="Constructor for this CFC">

		<cfargument name="DSN" type="string" required="yes" displayname="Data Source Name" hint="I am the data source to use for persistence." />
		<cfargument name="TemplatePath" type="string" required="yes" displayname="Template Path" hint="I am the Path to get the templates from" />
		<cfargument name="NewBeanPath" type="string" required="yes" displayname="New Bean Path" hint="I am the Path to store the new files into." />
		<cfargument name="CSVpath" type="string" required="yes" displayname="Path to CSV Files" hint="I am the Path to the CSV Files." />

		<cfset variables.DSN = arguments.DSN />
		<cfset variables.TemplatePath = arguments.TemplatePath />
		<cfset variables.NewBeanPath = arguments.NewBeanPath />
		<cfset variables.CSVpath = arguments.CSVPath />



		<!--- return the object itself --->
		<cfreturn this />
	</cffunction>
	
<!--- Library Functions --->
<cffunction name="SetupBean" access="public" returntype="query" hint="Reads the table and creates a structure of its definition">
 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>
<cfset var  beans="">
<cfset beans = ReadCSV(arguments.event)>

 <cfreturn beans>


</cffunction>
<!--- 
Read a table and build a structure of it's definition for a new bean
 --->
		<cffunction name="ReadTable" access="public" output="false" 
			returntype="query" 
			hint="Reads the table and creats a strructure of its definition">
 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfset var tablename = event.getarg("tablename")>
<cfset var tableQuery="">
<cfset var lstColumns="">
<cfset var beans = "">
<cfset var strColumnName="">
<cfset var NumberOfBeans=0>
<cfset var intColumn="">
<cfset var CVSfile="">
<cfset var CSVName = "#variables.csvpath##tablename#.csv">
<cfset var lstArray = "">
<!--- Get the bean definition template --->

<cfquery name="tableQuery" datasource="#variables.dsn#" maxrows="1">
SELECT * FROM #tablename#
</cfquery>
<cfset lstColumns =#QueryColumns(tableQuery)#>
<cfset Beans = arraynew(1)>

 <!---
 Loop over the columns in the query. This time, we are
 looping over the list items themselves.
 --->
<cfset Beans = arraynew(1)>
<cfloop index="strColumnName"  list="#lstColumns#"  delimiters=",">

<!--- Now build a query merging the table with the template --->
<cfset NumberOfBeans = arraylen(beans)+1>
<cfset abean =structnew()>

<cfset abean.columnName=strColumnName>
<cfset abean.defaultValue="">
<cfset abean.Displayname=abean.ColumnName>
<cfset abean.DataType="">
<cfset abean.RequiredFlag="1">
<cfset abean.Header="">
<cfset abean.Notes="">

<cfset beans[NumberOfBeans] = structnew()>
<cfset beans[NumberofBeans] = abean>
</cfloop>

<cfdump var = "#Beans#">
<cfset lstcolumns="fieldname," & lstcolumns>
<cfset tablequery = queryNew(lstColumns)>
<!--- Now build the empty definition File --->
<cfset queryaddrow(tablequery)>
<cfset queryaddrow(tablequery)>
<cfset queryaddrow(tablequery)>
<cfset queryaddrow(tablequery)>
<cfset queryaddrow(tablequery)>
<cfset queryaddrow(tablequery)>
<cfset queryaddrow(tablequery)>

<cfloop index="strColumnName"  list="#lstColumns#"  delimiters=",">
<cfset querysetcell(tablequery,strColumnName,strColumnName,2)>
<cfset querysetcell(tablequery,strColumnName,"1",3)>
</cfloop>
<cfset querysetcell(tablequery,"fieldName","DataType",1)>
<cfset querysetcell(tablequery,"fieldName","DisplayName",2)>
<cfset querysetcell(tablequery,"fieldName","RequiredFlag",3)>
<cfset querysetcell(tablequery,"fieldName","DefaultValue",4)>
<cfset querysetcell(tablequery,"fieldName","Header",5)>
<cfset querysetcell(tablequery,"fieldName","Notes",6)>
<cfset querysetcell(tablequery,"fieldName","Key",7)>

<!--- return the raw bean --->
<cfset tablequery= TransposeDefinition(tablequery,true)>
<cfset lstarray = listtoarray(lstColumns)>
<cfset lstarrary = arraydeleteat(lstarray,1)>
<cfset queryAddcolumn(tablequery,"PropertyName",lstarray)>
<cfreturn tablequery>
	</cffunction>

<cffunction name="TransposeDefinition" returntype="query">
	<cfargument name="inputQuery" type="query" required="true">
	<cfargument name="includeHeaders" type="boolean" default="true" required="false">
		
	<cfset var outputQuery = QueryNew("")>
	<cfset var columnsList = QueryColumns(inputQuery)>
	<cfset var newColumn = ArrayNew(1)>
	<cfset var row = 1>
	<cfset var zeroString = "000000">
	<cfset var padFactor = int(log10(inputQuery.recordcount)) + 1 >
	<cfset var i = "">
<cfloop query="inputQuery">
		<cfset newColumn[currentrow] = inputQuery[ListGetAt(columnsList, 1)][currentrow]>
	</cfloop>
<cfset headers = arraytolist(newcolumn)>


<cfloop query="inputQuery">
<cfset newcolumn=arrayNew(1)>
	<cfloop index="i" from="1" to="#listlen(columnsList)#">
		<cfset newColumn[i] = inputQuery[ListGetAt(columnsList, i)][currentRow]>
	</cfloop>
	
	

		<cfset queryAddColumn(outputQuery,listgetat(headers,currentrow),newcolumn)>
	</cfloop>

<!--- Delete the first row, as it is also the header --->
<cfquery name="outputQuery"  dbtype="query">
select * from outputQuery
WHERE datatype <> 'DataType'
</cfquery>
<cfset session.ColumnList  = headers>
	<cfreturn outputQuery>
</cffunction>




<cfscript>





/**
 * Transform a query result into a csv formatted variable.
 * 
 * @param query 	 The query to transform. (Required)
 * @param headers 	 A list of headers to use for the first row of the CSV string. Defaults to cols. (Optional)
 * @param cols 	 The columns from the query to transform. Defaults to all the columns. (Optional)
 * @return Returns a string. 
 * @author adgnot sebastien (sadgnot@ogilvy.net) 
 * @version 1, June 26, 2002 
 */
function QueryToCsv(query){
	var csv = "";
	var cols = "";
	var headers = "";
	var i = 1;
	var j = 1;
	
	if(arrayLen(arguments) gte 2) headers = arguments[2];
	if(arrayLen(arguments) gte 3) cols = arguments[3];
	
	if(cols is "") cols = QueryColumns(Query);
	if(headers IS "") headers = cols;
	
	headers = listToArray(headers);
	
	for(i=1; i lte arrayLen(headers); i=i+1){
		csv = csv & """" & headers[i] & """,";
	}

	csv = csv & chr(13) & chr(10);
	
	cols = listToArray(cols);
	
	for(i=1; i lte query.recordCount; i=i+1){
		for(j=1; j lte arrayLen(cols); j=j+1){
			csv = csv & """" & query[cols[j]][i] & """,";
		}		
		csv = csv & chr(13) & chr(10);
	}
	return csv;
}
</cfscript>

<!--- 
Read a CSV File and build a structure of it's definition for a new bean
 --->
 
 	<cffunction name="ReadCSV" access="public" output="false" 
			returntype="Query" 
			hint="Reads a CSV file and creates a query of its definition">
 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>


<cfset var tablename = event.getarg("tablename")>
<cfset var tableQuery="">
<cfset var CSVfile="">
<cfset var CSVName = "#variables.csvpath##tablename#.csv">

<cffile action="read" file="#CSVname#" variable="CSVfile">
<cfset tablequery = "#CSVToQuery(CSVFile)#">
<cfreturn tablequery>

</cffunction>
 
	

<!--- 
Capitalize the first letter of each word, lowercase the rest
 --->
 
  <cffunction name="CapFirst" access="public" output="false" returntype="string"
			hint="Converts first letter of each word to cap">
	<cfargument name="str" type="string" required="true" />
	<cfset var newstr = "" />
	<cfset var word = "" />
	<cfset var separator = "" />

	<cfloop index="word" list="#arguments.str#" delimiters=" ">
		<cfset newstr = newstr & separator & UCase(left(word,1)) />


		<cfif len(word) gt 1>
			<cfset newstr = newstr & lcase(right(word,len(word)-1)) />
		</cfif>
		<cfset separator = " " />
	</cfloop>

	<cfreturn newstr />
</cffunction>

<cfscript>
/**
 * Makes a struct for all values in a given column(s) of a query.
 * 
 * @param query 	 The query to operate on (Required)
 * @param keyColumn 	 The name of the column to use for the key in the struct (Required)
 * @param valueColumn 	 The name of the column in the query to use for the values in the struct (defaults to whatever the keyColumn is) (Optional)
 * @param reverse 	 Boolean value for whether to go through the query in reverse (default is false) (Optional)
 * @return struct 
 * @author Nathan Dintenfass (nathan@changemedia.com) 
 * @version 1, July 9, 2003 
 */
function queryColumnsToStruct(query,keyColumn){
	var valueColumn = keyColumn;
	var reverse = false;
	var struct = structNew();
	var increment = 1;
	var ii = 1;
	var rowsGotten = 0;
	//if there is a third argument, treat that as the valueColumn
	if(arrayLen(arguments) GT 2)
		valueColumn = arguments[3];
	//if there is a 4th argument, use that as the reverse
	if(arrayLen(arguments) GT 3)
		reverse = arguments[4];	
	//if reversing, we go backwards through the query
	if(reverse){
		ii = query.recordCount;
		increment = -1;
	}	
	//loop through the query, populating the struct
	//we do the while loop rather than a for loop because we don't know what direction we're going in
	while(rowsGotten LT query.recordCount){
		struct[query[keyColumn][ii]] = query[valueColumn][ii];
		ii = ii + increment;
		rowsGotten = rowsGotten + 1;		
	}
	return struct;
}
function queryColumns(dbquery) {
//Builds a list of the Column Names. We'll loop trough this later
//Could have used dbquery.columnlist but it returns the llist in sorted order, not the order of appearance
	var queryFields = "";
	var metadata = dbquery.getMetadata();
	var i = 0;
	var col = "";
	
	for (i = 1; i lte metadata.getColumnCount(); i = i+1) {
		col = metadata.getColumnLabel(javaCast("int", i));
		queryFields = listAppend(queryFields,col);
	}

	return queryFields;
}

function csvToQuery(csvString){
	var rowDelim = chr(10);
	var colDelim = ",";
	var numCols = 1;
	var newQuery = QueryNew(""); //create an empty query
	var arrayCol = ArrayNew(1);
	var arrayCol2 = ArrayNew(1);
	var i = 1;
	var j = 1;
	var tmp= "";

//Normalize the CSV input.
// CSVformat is a comma delimited listof values, one row at a time.
// They are normally terminated with a linefeed but MS likes to  use CRLF instead.
//CF has a bug n the ListToArray function; It throws away 'empty' fields which throwws everything out of alignment.
//We handle it by inserting the word 'NULL' into these 'empty fields.
//You will notice that the

    csvString = replace(csvString,chr(13) & chr(10) ,chr(10),"all") ;
//handle the first field being empty
    csvString = replace(csvString,chr(10)  & ",",chr(10) & "NULL,","all");

// fill the empty fields. do it twice because even though we said all, the replace function misses
// back to back instances (this is true in a number of other languages too (java, C, VB, and a couple more that I know of.	
	csvString = replace(csvString,",,",",NULL,","all");
	csvString = trim(replace(csvString,",,",",NULL,","all"));
// add a null to the end, just to make listtoarray work right	
	if (right(csvString,1) eq ","){ csvString = csvString & "NULL";}

	//optional parameters may be called rowdelim a d coldelim. They are defined above just in case the are not passed
	if(arrayLen(arguments) GE 2) rowDelim = arguments[2];
	if(arrayLen(arguments) GE 3) colDelim = arguments[3];

//build the array of columns
	arrayCol = listToArray(listFirst(csvString,rowDelim),colDelim);
	arrayCol2 = listToArray(listFirst(csvString,rowDelim),colDelim);

//	make 'friendly' column nnames (friendly to CF queries, spaces in anme become underscores.
// There are other rules but we are currently only enforcing this one.
//Loop through the array and replace spaces with underscores. Note that we are assuming that there are no double spaces in th CSV file
	for(i=1; i le arrayLen(arrayCol); i=i+1){ 
	 arrayCol[i] = replace(arrayCol[i]," ","_","all");// replace blank in column name with underscores
	 arraycol[i] = reReplace(arraycol[i], '[\W]', '', 'all');//Strip Special Characters
	}
//Add the friendly column name to the query
	for(i=1; i le arrayLen(arrayCol); i=i+1) queryAddColumn(newQuery, arrayCol[i], ArrayNew(1));

//Save the original column names in the first row
//		queryAddRow(newQuery);
//			for(j=1; j le arrayLen(arrayCol); j=j+1) {
//	     		querySetCell(newQuery, arrayCol[j],arraycol2[j], 1);
			  
//		    }

//loop through the rows
	for(i=2; i le listLen(csvString,rowDelim); i=i+1) {
		queryAddRow(newQuery);

//Loop through the columns for the current row
		for(j=1; j le arrayLen(arrayCol); j=j+1) {
			if(listLen(listGetAt(csvString,i,rowDelim),colDelim) ge j) {
//Get the data from the column
			tmp = listGetAt(listGetAt(csvString,i,rowDelim),j,colDelim);
// Look for the empty flag (created above by all those replaces staments and deal with it
			if (tmp eq "NULL") tmp="";
//Store the data from the CSV cell in the query cell			
				querySetCell(newQuery, arrayCol[j],tmp, i-1);
			}
		}
	}
	return newQuery;
}

</cfscript>



<cfscript>
/**
 * Sorts an array of structures based on a key in the structures.
 * 
 * @param aofS 	 Array of structures. 
 * @param key 	 Key to sort by. 
 * @param sortOrder 	 Order to sort by, asc or desc. 
 * @param sortType 	 Text, textnocase, or numeric. 
 * @param delim 	 Delimiter used for temporary data storage. Must not exist in data. Defaults to a period. 
 * @return Returns a sorted array. 
 * @author Nathan Dintenfass (nathan@changemedia.com) 
 * @version 1, December 10, 2001 
 */
function arrayOfStructsSort(aOfS,key){
		//by default we'll use an ascending sort
		var sortOrder = "asc";		
		//by default, we'll use a textnocase sort
		var sortType = "textnocase";
		//by default, use ascii character 30 as the delim
		var delim = ".";
		//make an array to hold the sort stuff
		var sortArray = arraynew(1);
		//make an array to return
		var returnArray = arraynew(1);
		//grab the number of elements in the array (used in the loops)
		var count = arrayLen(aOfS);
		//make a variable to use in the loop
		var ii = 1;
		//if there is a 3rd argument, set the sortOrder
		if(arraylen(arguments) GT 2)
			sortOrder = arguments[3];
		//if there is a 4th argument, set the sortType
		if(arraylen(arguments) GT 3)
			sortType = arguments[4];
		//if there is a 5th argument, set the delim
		if(arraylen(arguments) GT 4)
			delim = arguments[5];
		//loop over the array of structs, building the sortArray
		for(ii = 1; ii lte count; ii = ii + 1)
			sortArray[ii] = aOfS[ii][key] & delim & ii;
		//now sort the array
		arraySort(sortArray,sortType,sortOrder);
		//now build the return array
		for(ii = 1; ii lte count; ii = ii + 1)
			returnArray[ii] = aOfS[listLast(sortArray[ii],delim)];
		//return the array
		return returnArray;
}
</cfscript>





<!-- Create the bean -->

<cffunction name="CreateBean" access="public" output="false" 
			returntype="void" 
			hint="Creates a new bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>
 
<cfset var NewBeanName = event.getarg("NewBeanName")>
<cfset var bean ="">
<cfset var beantable = arraynew(1)>
<cfset var beanTemplaet="">
<cfset var beanTXT = "">
<cfset var beanArg = "">
<cfset var beanProperties="">
<cfset var beanAccessors="">
<cfset var beanIniters="">
<cfset var BeanIDfield = "">
<cfset var ColumnName="">
<cfset var crlf = chr(13) & chr(10)>
<cfset  var beandumpers='bean.beanname="#newBeanName#";'>
 <cfset var element="">


<cfloop index="bean" from="1" to="#beancount#">
<cfset beanstruct = structnew()>
<cfset beanstruct.ColumnName = event.getarg("PropertyName_" & bean)>
<cfset beanstruct.datatype = event.getarg("datatype_" & bean)>
<cfset beanstruct.displayname = event.getarg("displayname_" & bean)>
<cfset beanstruct.defaultvalue = event.getarg("defaultvalue_" & bean)>
<cfif beanstruct.defaultvalue is "">
   <cfset beanstruct.defaultvalue = '""'>
</cfif>
<cfset beanstruct.header = event.getarg("header_" & bean)>
<cfset beanstruct.Notes = event.getarg("notes_" & bean)>
<cfset beanstruct.RequiredFlag = event.getarg("RequiredFlag_" & bean)>
<cfif event.getarg("key") is bean>
<cfset beanstruct.Key = 1>
<!--- 
set the key, for now, only the last key checked will get done 
I'm planning on fixing it when I have more time to do it.
--->
<cfset beanIDfield = beanstruct.ColumnName>
<cfelse>
<cfset beanstruct.Key = 0>
</cfif>
<cfset session.BeanIDfield=beanIDfield>

<cfquery name="element" datasource="#variables.dsn#">
SELECT * from dictionary 
WHERE datatypename = '#beanstruct.dataType#'</cfquery>

 
<cfif element.recordcount is not 0>
<cfset beanstruct.CFdatatype = element.cfdatatype>
<cfset beanstruct.SQLdatatype = element.SQLdatatype>
<cfset beanstruct.InputType = element.inputType>
<cfset beanstruct.DisplayLen = element.Displaylen>
<cfset beanstruct.MaxLen = element.Maxlen>
<cfset beanstruct.Button = element.button>
<cfset beanstruct.Button = replacenocase(beanstruct.button,"|","'","all")>
<cfset beanstruct.Button = replacenocase(beanstruct.button,"##this##",beanstruct.ColumnName,"all")>
<cfset beanstruct.Params = element.Params>
<cfset beanstruct.ValidationScript = element.ValidationScript>
<cfset beanstruct.format = element.format>

<cfelse>
<cfset beanstruct.CFdatatype = "string">
<cfset beanstruct.SQLdatatype = "varchar">
<cfset beanstruct.InputType = "">
<cfset beanstruct.DisplayLen = 20>
<cfset beanstruct.MaxLen = 20>
<cfset beanstruct.Button = "">
<cfset beanstruct.Params = "">
<cfset beanstruct.key = "">
<cfset beanstruct.ValidationScript = "">
<cfset beanstruct.format="">
</cfif>


<cfset beantable[bean]=beanstruct>
</cfloop>

 <!---  Sort the bean by the displaySequence field --->
<!--- <<cfset beantable ="#arrayOfStructsSort(beantable,"DisplaySequence")#">
<cfset session.beantable=beanTable>
 --->

<cfset session.beantable=beantable>
<cffile action="read" file="#templatepath#bean.cfc" variable="beantemplate">
<!---
 Set the bean name to equal the tablename --->
 <cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfloop index="bean" from="1" to="#arraylen(beantable)#">


<!--- Build the bean arguments --->
<cfset beanarg = '<cfargument name="<propertyname>" type="<propertyType>" required="false" default=<propertyDefault> />'>
<cfset beanarg = replacenocase(beanArg,"<propertyname>","#beantable[bean].ColumnName#")>
<cfset beanarg = replacenocase(beanArg,"<propertytype>","#lcase(beantable[bean].CFDataType)#")>
<cfset beanarg = replacenocase(beanArg,"<propertyDefault>","#lcase(beantable[bean].DefaultValue)#")>
<cfset BeanProperties = beanproperties & BeanArg & crlf>

<!--- Build the dumpers --->


<cfset beanarg = 'bean.<PropertyName> =get<propertyName>();'>
<cfset beanarg = replacenocase(beanArg,"<propertyname>","#beantable[bean].ColumnName#","all")>
<cfset BeanDumpers = BeanDumpers & crlf & BeanArg>


<!--- build the initers --->

<cfset beanarg = '<cfset set<PropertyName>(arguments.<propertyName>) />'>
<cfset beanarg = replacenocase(beanArg,"<propertyname>","#beantable[bean].ColumnName#","all")>
<cfset BeanIniters = BeanIniters & BeanArg & crlf>

<!--- Build the accessors --->
<cfset beanarg = '<setter>
<cffunction name="set<propertyName>" access="public" returntype="void" output="false">
	<cfargument name="<propertyname>" type="<propertyType>" required="true" />
	<cfset variables.instance.<propertyName> = arguments.<propertyName> />#crlf#</cffunction>
<getter>
<cffunction name="get<propertyName>" access="public" returntype="<propertyType>" output="false">
	<cfreturn variables.instance.<propertyName> />#crlf#</cffunction>
'>

<cfset beanarg = replacenocase(beanArg,"<propertyname>","#beantable[bean].ColumnName#","all")>
<cfset beanarg = replacenocase(beanArg,"<propertytype>","#lcase(beantable[bean].CFDataType)#","all")>

<cfset beanarg = replacenocase(beanArg,"<getter>","<!-- getter for #beantable[bean].ColumnName# -->","all")>

<cfset beanarg = replacenocase(beanArg,"<setter>","<!-- setter for #beantable[bean].ColumnName# -->","all")>

<cfset BeanAccessors = beanAccessors & BeanArg & crlf>

</cfloop>
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<properties>","#beanProperties#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandump>","#beanDumpers#")> 
<cfset beanTXT = replacenocase(beanTXT,"<accessors>","#beanAccessors#")> 
<cfset beanTXT = replacenocase(beanTXT,"<initers>","#beanIniters#")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 

<cfset beanTXT = replacenocase(beanTXT,"<CRUDcreateMethod>","#CRUDcreateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDreadMethod>","#CRUDreadMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDupdateMethod>","#CRUDupdateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDdeleteMethod>","#CRUDdeleteMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<GetAllRecordsMethod>","#GetAllRecordsMethod#","all")> 


<cftry>
<cfdirectory action="DELETE" directory="#newBeanPath#">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#" action="create">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#\config" action="create">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#\filters" action="create">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#\model" action="create">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#\model\#newbeanname#" action="create">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#\plugins" action="create">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#\views\" action="create">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#\images\" action="create">
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfdirectory directory="#newBeanPath#\views\layout" action="create">
<cfcatch></cfcatch>
</cftry>


<cffile action="write" addnewline="yes" file="#newBeanPath#\model\#Newbeanname#\#NewBeanName#.cfc" output="#beanTXT#" fixnewline="no">
	</cffunction>
	
	
	
	
	
	
<!-- Create the Listener -->

<cffunction name="CreateListener" access="public" output="false" 
			returntype="void" 
			hint="Creates a new Listerner  for CRUD functions for the bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>
	
<cfset var NewBeanName = event.getarg("NewBeanName")>
<cfset var beans = session.beantable>
<cfset var beanIDfield = session.beanIDfield>

<cfset var beanTXT = "">

 <cfset var crlf = chr(13) & chr(10)>

<!--- Read the template --->
<cffile action="read" file="#templatepath#listener.cfc" variable="beantemplate">


 Set the bean name to equal the tablename --->
 <cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<tablename>","#tablename#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanIDfield>","#beanIDfield#","all")> 

<cfset beanTXT = replacenocase(beanTXT,"<CRUDcreateMethod>","#CRUDcreateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDreadMethod>","#CRUDreadMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDupdateMethod>","#CRUDupdateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDdeleteMethod>","#CRUDdeleteMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<GetAllRecordsMethod>","#GetAllRecordsMethod#","all")> 

<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\model\#Newbeanname#\#NewBeanName#Listener.cfc" output="#beanTXT#" fixnewline="no">


 </cffunction>
 
 
 
 
 
 
 
 

<!--- Create the DAO --->
 <cffunction name="CreateDAO" access="public" output="false" 
			returntype="void" 
			hint="Creates a new DAO for CRUD functions for the bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfset var NewBeanName = event.getarg("NewBeanName")>
<cfset var beans = session.beantable>
<cfset var beanIDfield = session.beanIDfield>
<cfset var beanTXT = "">
<cfset var crlf = chr(13) & chr(10)>
<cfset var beanargs="">
 <cfset var  updateargs="">
 <cfset var beanfields = "">
 <cfset var Entrybeanfields = "">
 <cfset var BeanFieldInserts="">
 <cfset var BeanFieldUpdates="">
<cfset var BeanIDtype = "">
 
<!--- build acomma delimited list of fields --->
 <cfloop index="bean" from="1" to="#arraylen(beans)#">
<cfset Beanargs = '<cfqueryparam value="##arguments.entry.get#beans[bean].ColumnName#()##" cfsqltype="<SQL_DATATYPE>">'>
<!--- Now get the SQL DataTYPE --->
<cfset beanargs = replacenocase(beanargs,"<SQL_DATATYPE>","CF_SQL_#beans[bean].SQLDataType#")>

<cfset UpdateArgs = '#beans[bean].ColumnName# = <cfqueryparam value="##arguments.entry.get#beans[bean].ColumnName#()##" cfsqltype="<SQL_DATATYPE>">'>
<!--- Now get the SQL DataTYPE --->
<cfset Updateargs = replacenocase(UpdateArgs,"<SQL_DATATYPE>","CF_SQL_#beans[bean].SQLDataType#")>

<cfif beanIDfield is beans[bean].ColumnName>
<cfset BeanIDtype = "CF_SQL_#beans[bean].SQLDataType#">
</cfif>


<cfif beanfields is "">
<cfset EntryBeanFields = "getEntry.#beans[bean].ColumnName#" >
<cfset BeanFields = "#beans[bean].ColumnName#" >
<cfset BeanFieldInserts = beanargs>
<cfelse>
<cfset BeanFields = beanfields & "," & "#beans[bean].ColumnName#" >
<cfset EntryBeanFields = EntryBeanFields & ","  & "getEntry.#beans[bean].ColumnName#" >
<cfset BeanFieldInserts = BeanFieldInserts & "," & crlf & beanargs >
</cfif>


<cfif beans[bean].ColumnName is not beanidfield>
<cfif beanfieldUpdates is "">
<cfset BeanFieldUpdates = UpdateArgs>
<cfelse>
<cfset BeanFieldUpdates = BeanFieldUpdates & "," & crlf & UpdateArgs>
</cfif>
</cfif>


</cfloop>




<!--- Read the template --->
<cffile action="read" file="#templatepath#DAO.cfc" variable="beantemplate">


 Set the bean name to equal the tablename --->
 <cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<tablename>","#tablename#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanIDfield>","#beanIDfield#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanIDType>","#beanIDType#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanEntryfields>","#entrybeanfields#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanfields>","#beanfields#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanfieldInserts>","#beanfieldInserts#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanfieldUpdates>","#beanfieldUpdates#","all")> 


<cfset beanTXT = replacenocase(beanTXT,"<CRUDcreateMethod>","#CRUDcreateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDreadMethod>","#CRUDreadMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDupdateMethod>","#CRUDupdateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDdeleteMethod>","#CRUDdeleteMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<GetAllRecordsMethod>","#GetAllRecordsMethod#","all")> 

<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\model\#Newbeanname#\#NewBeanName#DAO.cfc" output="#beanTXT#" fixnewline="no">

 </cffunction>
 
<!---  
Create the  Services
 --->
 <cffunction name="CreateServices" access="public" output="false" 
			returntype="void" 
			hint="Creates a Services object for library functions for the bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfset var NewBeanName = event.getarg("NewBeanName")>
<cfset var beans = session.beantable>
<cfset var beanIDfield = session.beanIDfield>
<cfset var beanTXT = "">
<cfset var crlf = chr(13) & chr(10)>

<!--- Read the template --->
<cffile action="read" file="#templatepath#Services.cfc" variable="beantemplate">


<!-- Set the bean name to equal the tablename --->
 <cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<tablename>","#tablename#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 
 
<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\model\#Newbeanname#\#NewBeanName#Services.cfc" output="#beanTXT#" fixnewline="no">
	 
 </cffunction>

 
 
 
 
 
 
<!-- Create the Gateway -->
 <cffunction name="CreateGateway" access="public" output="false" 
			returntype="void" 
			hint="Creates a new Gateway for CRUD functions for the bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfset var NewBeanName = event.getarg("NewBeanName")>
<cfset var beans = session.beantable>
<cfset var beanIDfield = session.beanIDfield>
<cfset var beanTXT = "">
<cfset var BeanIniters="">
 <cfset var crlf = chr(13) & chr(10)>

<!--- Read the template --->
<cffile action="read" file="#templatepath#Gateway.cfc" variable="beantemplate">


<!--- Set the bean name to equal the tablename --->
 <cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<tablename>","#tablename#","all")> 

<cfset beanTXT = replacenocase(beanTXT,"<GetAllRecordsMethod>","#GetAllRecordsMethod#","all")> 


<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\model\#Newbeanname#\#NewBeanName#Gateway.cfc" output="#beanTXT#" fixnewline="no">
	 
 </cffunction>
 

 <cffunction name="CreateBeanerFilter" access="public" output="false" 
			returntype="void" 
			hint="Creates a new BeanerFilter for the bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfset var NewBeanName = event.getarg("NewBeanName")>
<cfset var beans = session.beantable>
<cfset var beanIDfield = session.beanIDfield>
<cfset var beanTXT = "">
<cfset var BeanIniters="">
 <cfset var crlf = chr(13) & chr(10)>
<!--- Read the template --->
<cffile action="read" file="#templatepath#BeanerFilter.cfc" variable="beantemplate">
		
		
<cfloop index="bean" from="1" to="#arraylen(beans)#">
<!--- build the initers --->

<cfset beanarg = 'bean.set<PropertyName>(arguments.event.getArg("<PropertyName>", #beans[bean].defaultValue#));'>

<cfset beanarg = replacenocase(beanArg,"<propertyname>","#beans[bean].ColumnName#","all")>
<cfset BeanIniters = BeanIniters & BeanArg & crlf>
</cfloop>

<!--- Build the bean arguments --->

<cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<tablename>","#tablename#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<initers>","#beanIniters#")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 

<cfset beanTXT = replacenocase(beanTXT,"<CRUDcreateMethod>","#CRUDcreateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDreadMethod>","#CRUDreadMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDupdateMethod>","#CRUDupdateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDdeleteMethod>","#CRUDdeleteMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<GetAllRecordsMethod>","#GetAllRecordsMethod#","all")> 

<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\filters\#NewBeanName#BeanerFilter.cfc" output="#beanTXT#" fixnewline="no">
		
		
 </cffunction>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  <cffunction name="CreateConfigFile" access="public" output="false" 
			returntype="void" 
			hint="Creates a new Gateway for CRUD functions for the bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>
	
<cfset var NewBeanName = event.getarg("NewBeanName")>
<cfset var beans = session.beantable>
<cfset var beanIDfield = session.beanIDfield>
<cfset var BeanRow = "">
<cfset var beanTXT = "">
<cfset var BeanIniters="">
<cfset var requiredfields = "">
 <cfset var crlf = chr(13) & chr(10)>

<cfset var beanfields = "">
<!--- build acomma delimited list of fields --->
 <cfloop index="bean" from="1" to="#arraylen(beans)#">
<cfset beanarg = replacenocase(beanArg,"<propertyname>","#beans[bean].ColumnName#","all")>

<cfif BeanFields is "">
<cfset BeanFields = "#beans[bean].ColumnName#" >
<cfelse>
<cfset BeanFields = BeanFields & ","  & "#beans[bean].ColumnName#" >
</cfif>


<cfif lcase(beans[bean].Requiredflag) is "1">
<cfif RequiredFields is "">
<cfset requiredFields = "#beans[bean].ColumnName#" >
<cfelse>
<cfset RequiredFields = RequiredFields & ","  & "#beans[bean].ColumnName#" >
</cfif>
</cfif>
</cfloop>

 
 
 
<!--- Read the template --->
<cffile action="read" file="#templatepath#mach-ii.xml" variable="beantemplate">


<!--- Set the bean name to equal the tablename --->
 <cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<tablename>","#tablename#","all")> 
 <cfset beanTXT = replacenocase(beanTXT,"<beanfields>","#beanfields#","all")>
 <cfset beanTXT = replacenocase(beanTXT,"<Requiredfields>","#requiredfields#","all")>
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 

<cfset beanTXT = replacenocase(beanTXT,"<CRUDcreateMethod>","#CRUDcreateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDreadMethod>","#CRUDreadMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDupdateMethod>","#CRUDupdateMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<CRUDdeleteMethod>","#CRUDdeleteMethod#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<GetAllRecordsMethod>","#GetAllRecordsMethod#","all")> 

<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\config\mach-ii.xml" output="#beanTXT#" fixnewline="no">
	 
 </cffunction>
 
 

  <cffunction name="CreateViewFiles" access="public" output="false" 
			returntype="void" 
			hint="Creates forms for using the new bean">
	 <cfargument name="event" type="MachII.framework.Event" required="yes" displayname="Event"/>

<cfset var beans = session.beantable>
<cfset var beanIDfield = session.beanIDfield>
<cfset var crlf = chr(13) & chr(10)>
<cfset var beanListFields="">
<cfset var Beanheader="">
<cfset var params ="">
<cfset var param = "">
<!--- HEADER --->
<CFSET var BeanTemplate = "">
<!--- Read the template --->
<cffile action="read" file="#templatepath#header.cfm" variable="beantemplate">

<cfsavecontent variable="validateCode">
<!--- Handle all the required fields --->
 <cfoutput>
 <cfloop index="bean" from="1" to="#arraylen(beans)#">
<cfset colname = "document.forms[0]." &  beans[bean].ColumnName>
<cfset DisplayName = beans[bean].DisplayName>
<cfset ValidationScript = beans[bean].ValidationScript>

<cfif beans[bean].requiredFlag><!---  is required  --->

<cfswitch expression="#lcase(beans[bean].inputtype)#"><!--- type of input --->

<cfcase value="radio"> <!--- radio Button --->
var btn = validateButton(#colname#);
if (btn == null) {
alert("You must pick a #displayName#");
return false;
}
</cfcase>

<cfcase value="select"> <!--- select --->
if (!SingleSelectRequired(#colname#)){
alert("You must enter a #displayName#");
return false;
}
</cfcase>

<cfdefaultcase> <!--- everything else --->
if (!isRequired(#colname#.value)){
alert("You must enter a #displayName#;");
return false;
}
</cfdefaultcase>
</cfswitch>

</cfif>


<!--- Now handle the validation for the datatypes --->
<!--- Phase 2 special Validation beyond simply requiring input( format checking, etc) --->

<cfswitch expression="#lcase(ValidationScript)#">

<cfcase value="comments">
if (#colname#.value.length > #beans[bean].maxlen#){
alert("#displayName# is too long. Maximum length: "+#beans[bean].maxlen#);
return false;
}
</cfcase>

<cfcase value="email">
if (#colname#.value.length!=0 && !validateEmail(#colname#.value)){
alert("You must enter #displayName# in the following format: #beans[bean].format#");
return false;
}
</cfcase>

<cfcase value="ip">
if (#colname#.value.length!=0 && !validateIP(#colname#.value)){
alert("You must enter #displayName# in the following format(: #beans[bean].format#");
return false;
}
</cfcase>

<cfcase value="phone">
if (#colname#.value.length!=0 && !validateUSPhone(#colname#.value)){
alert("You must enter #displayName# in the following format: #beans[bean].format#");
return false;
}
</cfcase>
<cfcase value="state">
<!--- Depends on Country, look in the grouplist and see if there is a element with 'country' in it --->


if (#colname#.value.length!=0 && !validateState(#colname#.value)){
alert("For Addresses in the United States, you must enter a state");
return false;
}

</cfcase>


<cfcase value="zip">

if (#colname#.value.length!=0 && !validateUSZip(#colname#.value)){
alert("You must enter #displayName# in the following format: #beans[bean].format#");
return false;
}

</cfcase>
</cfswitch>

</cfloop>
</cfoutput>
</cfsavecontent>



 <cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<validaters>","#validateCode#","all")> 
<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\views\layout\header.cfm" output="#beanTXT#" fixnewline="no">

<!--- FOOTER --->
<CFSET BeanTemplate = "">
<!--- Read the template --->
<cffile action="read" file="#templatepath#footer.cfm" variable="beantemplate">
 <cfset beanTXT = replacenocase(beanTemplate,"<beanname>","#NewBeanName#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 
<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\views\layout\footer.cfm" output="#beanTXT#" fixnewline="no">

<!--- LISTER --->

<cfset beanfields = "">

<!--- build acomma delimited list of fields --->
 <cfloop index="bean" from="1" to="#arraylen(beans)#">
<cfif beanfields is "">
<cfset BeanFields = "<tr><th>#beans[bean].ColumnName#" >
<cfset BeanListFields = "<td>###beans[bean].ColumnName###" >
<cfelse>
<cfset BeanFields = BeanFields &  "</th><th>#beans[bean].ColumnName#" >
<cfset BeanListFields = BeanlistFields &  "</td><td>###beans[bean].ColumnName###" >
</cfif>

</cfloop>
<cfset beanfields = beanfields & "</th><th>Actions</th></tr>">
<cfset beanListfields = beanListfields & '</td><td><a href="index.cfm?event=Edit<beanname>&<beanIDField>=##<beanIDField>##">EDIT</a> \ <a href="index.cfm?event=Delete<beanname>&<beanIDField>=##<beanIDField>##">DELETE</a></td>'>

<CFSET BeanTemplate = "">

<!--- Read the template --->
<cffile action="read" file="#templatepath#list.cfm" variable="beantemplate">
 <cfset beanTXT = replacenocase(beanTemplate,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 
 <cfset beanTXT = replacenocase(beanTXT,"<headers>","#beanfields#","all")>
 <cfset beanTXT = replacenocase(beanTXT,"<beanlistFields>","#beanlistfields#","all")>
<cfset beanTXT = replacenocase(beanTXT,"<beanIDfield>","#beanIDfield#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanname>","#NewBeanName#","all")> 
<!--- assume the directories are built previously --->
<cffile action="write" addnewline="yes" file="#newBeanPath#\views\#NewBeanName#list.cfm" output="#beanTXT#" fixnewline="no">
















<!--- FORM --->

<cfset beanFormFields = "">

<!--- build acomma delimited list of fields --->
 <cfloop index="bean" from="1" to="#arraylen(beans)#">
<Cfset beanrow="">

<cfif beans[bean].header is not "">
<cfset Beanheader='<td></td><td><b>#beans[bean].header#</b><br></td></tr>'>
<cfelse>
<cfset Beanheader="">
</cfif>


<!--- Ok, now we need to deal with the datatype input type --->
<cfswitch expression="#lcase(beans[bean].inputtype)#">

<!--- Handle checkboxes --->
<cfcase value="checkbox">
<cfset beanRow = Beanheader & '
<cfif ###NewBeanName#.get#beans[bean].ColumnName#()## is 1>
<th align="right">#beans[bean].ColumnName#:</th><td><input type="Checkbox"  name="#beans[bean].ColumnName#" checked value="###NewBeanName#.get#beans[bean].ColumnName#()##" /></td>
<cfelse>
<th align="right">#beans[bean].ColumnName#:</th><td><input type="Checkbox"  name="#beans[bean].ColumnName#"  value="###NewBeanName#.get#beans[bean].ColumnName#()##" /></td>
</cfif>
'>

</cfcase>

<!--- Handle dates --->
<cfcase value="date">

<cfset beanRow = Beanheader & '
<th align="right">#beans[bean].ColumnName#:</th><td><input type="text"  name="#beans[bean].ColumnName#" size="#beans[bean].displaylen#" maxlength = "#beans[bean].displaylen#" value="###NewBeanName#.get#beans[bean].ColumnName#()##" />
#beans[bean].button#
</td>
'>

</cfcase>


<!--- Handle radio buttons --->
<cfcase value="radio">
<cfset params = listtoarray(beans[bean].params)>
<cfset BeanRow=Beanheader & '<th align="right">#beans[bean].ColumnName#:</th><td>'>
 <cfloop index="param" from="1" to="#arraylen(params)#">

 <cfset bits =listtoarray(params[param],"|")>


<cfset beanRow = beanrow & '
<cfif ###NewBeanName#.get#beans[bean].ColumnName#()## is "#bits[1]#">
<input type="radio"  checked="checked" name="#beans[bean].ColumnName#" value="#bits[1]#" />#bits[2]#
<cfelse>
<input type="radio"  name="#beans[bean].ColumnName#" value="#bits[1]#" />#bits[2]#
</cfif>
'>
</cfloop>
<cfset beanrow=beanrow & '</td>'>

</cfcase>

<!--- Handle Drop down select boxes --->
<cfcase value="select">
<cfset sbarray = "">
<cfset index = "">
<cfset SelOptions="">
<cfset selval = "">

<cfset sbArray = listtoarray(beans[bean].params)>

<cfset BeanRow=Beanheader & '<th valign="top" align="right">#beans[bean].ColumnName#:</th><td>'>
<cfset beanRow = beanrow & '
<select name="#beans[bean].columnname#" size="#beans[bean].displaylen#">
<option value="">&nbsp;</option><!--- first entry must be empty (for validation if nothing else) --->
'>


<cfloop index="index" from="1" to="#arrayLen(sbarray)#">
<cfset SelOptions = listtoarray(sbarray[index],"|")>
<cfif arraylen(seloptions) is 2>
<cfset selval=seloptions[2]>
<cfelse>
<cfset selval=seloptions[1]>
</cfif>
<cfset beanrow = beanrow & '
<option value="#seloptions[1]#"<CFIF lcase(###NewBeanName#.get#beans[bean].ColumnName#()##) is lcase("#seloptions[1]#")> selected</CFIF>>#selval#</option>
'>
</cfloop>
<cfset beanrow = beanrow & '</select>
</td>
'>


</cfcase>

<!--- Handle textareas --->
<cfcase value="textarea">
<cfset params = listtoarray(beans[bean].params)>
<cfset beanRow = Beanheader & '
<th align="right">#beans[bean].ColumnName#:</th><td><textarea  name="#beans[bean].ColumnName#" cols=#params[1]# rows=#params[2]#> ###NewBeanName#.get#beans[bean].ColumnName#()##</textarea></td>
'>

</cfcase>

<!--- Handle everyting else --->
<cfdefaultcase>
<cfset beanRow = Beanheader & '
<th align="right">#beans[bean].ColumnName#:</th><td><input type="text"  name="#beans[bean].ColumnName#" size="#beans[bean].displaylen#" maxlength = "#beans[bean].displaylen#" value="###NewBeanName#.get#beans[bean].ColumnName#()##" /></td>
'>
</cfdefaultcase>
</cfswitch>




<cfif beanFormFields is "">
<cfset BeanFormFields = "<tr valign='top'>#BeanRow#</tr>" >
<cfelse>
<cfset BeanFormFields = BeanFormFields & "<tr valign='top'>" &  #BeanRow# & "</tr>">
</cfif>

</cfloop>

<CFSET BeanTemplate = "">

<!--- Read the template --->
<cffile action="read" file="#templatepath#form.cfm" variable="beantemplate">
 <cfset beanTXT = replacenocase(beanTemplate,"<author>","#beanAuthor#")> 
<cfset beanTXT = replacenocase(beanTXT,"<beandate>","#beanCreationDate#")> 
<cfset beanTXT = replacenocase(beanTXT,"<appname>","#beanappName#","all")> 
 <cfset beanTXT = replacenocase(beanTXT,"<headers>","#beanfields#","all")>
 <cfset beanTXT = replacenocase(beanTXT,"<beanFormFields>","#beanFormFields#","all")>
<cfset beanTXT = replacenocase(beanTXT,"<beanIDfield>","#beanIDfield#","all")> 
<cfset beanTXT = replacenocase(beanTXT,"<beanname>","#NewBeanName#","all")> 
<!--- assume the directories are built previously --->

<cffile action="write" addnewline="yes" file="#newBeanPath#\views\#NewBeanName#Form.cfm" output="#beanTXT#" fixnewline="no">

<!--- Copy files needed to complete the application --->

<cftry>
<cffile action="read" file="#templatepath#applicationConstantsbean.cfc" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\model\applicationConstantsbean.cfc" output="#BeanTemplate#">
<cfcatch></cfcatch>
</cftry>
<cftry>
<cffile action="read" file="#templatepath#applicationplugin.cfc" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\plugins\applicationplugin.cfc" output="#BeanTemplate#" >
<cfcatch></cfcatch>
</cftry>

<cftry>
<cffile action="read" file="#templatepath#home.cfm" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\views\home.cfm" output="#BeanTemplate#" >
<cfcatch></cfcatch>
</cftry>

<cftry><cffile action="read" file="#templatepath#exception.cfm" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\views\exception.cfm" output="#BeanTemplate#" >
<cfcatch></cfcatch>
</cftry>

<cftry>
<cffile action="read" file="#templatepath#Maintemplate.cfm" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\views\MainTemplate.cfm" output="#BeanTemplate#" >
<cfcatch></cfcatch>
</cftry>

<cftry>
<cffile action="read" file="#templatepath#calendar.js" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\calendar.js" output="#BeanTemplate#" >
<cffile action="READBINARY" file="#templatepath#calendar.gif" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\images\calendar.gif" output="#BeanTemplate#" >

<cffile action="read" file="#templatepath#validate.js" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\validate.js" output="#BeanTemplate#" >

<cfcatch></cfcatch>
</cftry>



<cftry>
<cffile action="read" file="#templatepath#application.cfm" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#application.cfm" output="#BeanTemplate#" >
<cfcatch></cfcatch>
</cftry>

<cftry>
<cffile action="read" file="#templatepath#index.cfm" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#index.cfm" output="#BeanTemplate#" >
<cfcatch></cfcatch>
</cftry>

<cftry>
<cffile action="read" file="#templatepath#mach-ii.cfm" variable="beantemplate">
<cffile action="write" addnewline="yes" file="#newBeanPath#\mach-ii.cfm" output="#BeanTemplate#" >
<cfcatch></cfcatch>
</cftry>















</cffunction> 
 
 </cfcomponent>