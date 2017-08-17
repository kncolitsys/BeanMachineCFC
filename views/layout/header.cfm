<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
 "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<cfset libServices = event.getarg("libraryServices")>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title>BeanMachine - <cfoutput>#event.getArg("pageTitle")#</cfoutput></title>
	<link rel="stylesheet" type="text/css" href="layout.css" />
	<link rel="stylesheet" type="text/css" href="colours.css" title="Default" />
</head>

<body>
	<div id="banner"><h1>The Incredible mach-ii BeanMachine</h1>
	</div>
	<div id="navigation">
		<a href="index.cfm?event=showHome">Home</a> | 
		<a href="index.cfm?event=showIssues">Known issues</a>
	</div>
	<div id="sidebar">
		<div class="box">
	<h3>Navigation</h3>
 <ul>
<li><a href="index.cfm?event=ListDefinitions">List Bean Definitions</a></li>
<li><a href="index.cfm?event=ListTables">Create New Bean Definition</a></li>
</ul> <ul>
<li><a href="index.cfm?event=ListDictionary">List Dictionary</a></li>
<li><a href="index.cfm?event=AddDictionary">Add Dictionary Entry</a></li>
</ul>
	</div>
</div>

<cfoutput><cfif event.isArgDefined("message")><div class="errormessage">
			<p>#event.getArg("message")#</p></div>
		</cfif>
<h2>#event.getArg("pageTitle")#</h2></cfoutput><p>
