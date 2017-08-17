<p>This tool creates mach-ii beans, and its associated listener, DAO, Gateway, Services and config modules. It also creates a filter to make sure beans exist when they should and entry forms for handling CRUD functions.

<p></p>What would take literally hours by hand is now reduced to a few minutes.

<p>The bean generation is built around dealing with single tables in a database. The BeanMchine  reverse engineers the database table and produces a bean that matches the table's configuration.

<p>It then builds the DAO module to hand the CRUD (Create, Read, Update, Delete) functions, a Gateway to habdle multiple records (GetAllRecords is implemented), a sample Services module, a Listener to tie it all together and the config file to handle the CRUD functions and the  getallrecords event.

<p>It also builds a standard entry form to add/edit single records.

<p>All you have to do is enter the table name in the DSN defined in the config File, designate the bean name, change the capitalization of the field names, specify the ID filed used in the CRUD functions and let it go to town. All of the modules are created as files in the NewBeans directory of the BeanMachine.

<p>You should be able to put all the parts in the right place and it should go from the start.

<p>This is not meant to be an end all tool, rather, it is meant to save a lot of keyboard punching.


<p>Enter the name fo the table within the database (as defined in your config file) and press the generate button.
