How do I install and run Serve?
-------------------------------

    gem install serve

After Serve is installed, you can start it up in a given directory like this:

    serve

This will start Serve on port 4000. You can now view the prototype in your
Web browser at this URL:

<http://localhost:4000>


SASS & HAML
-----------

The style sheets for this project are written in SASS, the templates in HAML.

Learn more about Sass: <http://sass-lang.org>
Learn more about Sass: <http://haml-lang.com/>


Coffeescript
------------

The javascript for this project are written in Coffescript and compiled to javascript
on demand by the coffee-rack gem

Learn more about Coffescript: <http://jashkenas.github.com/coffee-script/>


JS Specs
--------

The specs are written using Jasmine. To run them open `spec/index.html`
in a browser. The specs themselves are written using Coffeescript, but since the 
specs aren't run off the server, you need to add a watcher:

    $ coffee -c -o spec/ --watch spec/ 

Learn more about Jasmine: <https://github.com/pivotal/jasmine/>


Rack and Passenger
------------------

Astute users may notice that this project is also a simple Rack application.
This means that it is easy to deploy it on Passenger or in any other
Rack-friendly environment. Rack it up with the `rackup` command. For more
information about using Serve and Passenger see:

<http://bit.ly/serve-and-passenger>


Exporting
---------

To export your project, use the new "export" command:

    serve export <project>:<output>

Where "project" is the path to the project and "output" is the path to the
directory where you would like your HTML and CSS generated.


Learning More
-------------

You can learn more about Serve on the GitHub project page:

<http://github.com/jlong/serve>
