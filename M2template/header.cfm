<!---
	COMPONENT: Header
	AUTHOR: <author>
	DATE: <beandate>
	PURPOSE: Head file for <appname>
	CHANGE HISTORY:
---><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
 "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title><appName> - <cfoutput>#event.getArg("pageTitle")#</cfoutput></title>
	<link rel="stylesheet" type="text/css" href="layout.css" />
	<link rel="stylesheet" type="text/css" href="colours.css" title="Default" />
<script src="calendar.js" type="text/javascript" ></script>
<script src="validate.js" type="text/javascript" ></script>
<script language="JavaScript">

function Validate(){
<validaters>
return true;
}
</script>

</head>

<body>
	<div id="banner"><h1><appname></h1>
	</div>
	<div id="navigation">
		<a href="index.cfm?event=Add<beanName>">Add Record</a> | 
		<a href="index.cfm?event=list<beanname>">List Records</a> | 

	</div>

<cfoutput><cfif event.isArgDefined("message")><strong>
			<p>#event.getArg("message")#</p></strong>
		</cfif>
<h2>#event.getArg("pageTitle")#</h2></cfoutput><p>
