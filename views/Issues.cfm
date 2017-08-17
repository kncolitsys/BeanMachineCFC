<ol>
<li>You can select more than one field for a key, but only the LAST one will get used. As this is currently only an Access database tested version, this is not as much of a problem than it would be in just about anything else. When I get some sleep, I'm planning on being able to use all the selected key fields but for not, stick to a single field. </li>
<li>There's no error checking on the above Issue.I's after 1 in the moringing and I need to get some sleep so I'll attack it on the next round if I can. I thought about making it a radio button for now, but...</li>
<li>
<li>The CSV file format has changed. The description column was replaced with a 'Key' column. if you try to use a file that uses the old format, you'll be instructed how to fix the CSV file. As this is a new system, there are not likely to be many people impacted too harsely, but as I combined two screens into one, the model and interface had to change so that's the direction I went.</li>
It is possible to have a field name in a bean definition file that conflicts with ColdFusion reserved words. This only happens inside the bean itself, with the getters and setters at run time. <p>For instance, in one of my tables, I have a field called class. Well, when you try to run the new application, you'll get an error to the effect that you can't use a Coldfusion reserved word. But you say 'Class isn't reserved'. True but GetClass is and that is where the problem arises. <p>The simple solution to this is to change the name in the definition of the bean, which can be done in the definition file or at generation time in the BeanMachine. Then, after the DAO is generated, edit it so that the CRUD functions use the correct column name. The change only needs to be done to the INSERT and UPDATE statements <p>You'll also have to edit the list VIEW page, since it is based on the bean definition and will have the wrong column name as well. <p> This is a bug that I plan on addressing after I get the rest of the machine working the way I want it to, more or less.
</li>
<li> Bean Validation remains to be built</li>
<li>Form validation remains to be built</li>
<li> No Documentation (Yet)</li>
<li>Not tested with anything other than Access. Nothing fancy that woudln't be handled by anything remotely standard, buut the DAO and gateway methods are Access centric, but hey you can change that.</li>
<li>The code for the forms generated is crude but it works.. Rapid prototyping does this. It'll get better over time</li>
<li>If you use anything that uses a datatype that is either a radio button, checkbox, or select box, make sure you put in default values or you'll get a weird error at runtime</li>
<li>Everything is still in my head so you'll have to email me (davee@wehali.com) if you have questions. </li>
</ol>
 