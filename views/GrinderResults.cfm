<cfset Results = session.buildresults />

<cfoutput>
<h4>Bean Build Results:</h4>
<ul>
<!--- <li>#results.bean#</li>  --->
<li>#results.Listener#</li>
<li>#results.DAO#</li>
<li>#results.Gateway#</li>
<li>#results.Services#</li>
<li>#results.BeanerFilter#</li>
<li>#results.Config#</li>
<li>#results.ViewPages#</li>
</ul></cfoutput>

<a href="/mymach2app" target="_blank">Try it in a new window</a>