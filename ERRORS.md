ERRORS
======

A list of errors I have made in development that I am recording so I don't make them again:
 - there is no ++ operator in Ruby. Syntax errors don't help with finding this.
 - make sure the DNS is working
 - Rails route helpers aren't always available
 - cannot log from another thread
 - Docker will rebuild when mtimes have changed, and Git doesn't store mtimes, which will prompt a rebuild every time you try
 - Keep all non-important state in the database
 - Always send data through to the site
 - Make sure Bundler has the Gemfile.lock available, otherwise `bundle install` will not install these specific versions 
 - Using update_attributes which would instantly save the record to the database even if there were errors, when I meant assign_attributes
 - JQuery running a function on an element which was a class, to which there were multiple in the page. Had to replace with an each loop.
 - Using LIKE query with strings NEEDS descending order if you want the most similar strings first. 
 - Ruby doesn't automatically strip newlines when iterating LINE-BY-LINE IN A TEXT FILE WTF
 - Rails forms are submitted using the usual $()[0].submit unless they are AJAX forms which are submitted using a JQuery trigger event for rails
 - Set up methods for creating defaults on new records so that you can use them in form construction for both new and preexisting records
 - You must convert number parameters into their appropriate integer values
 - Make sure to use Time.zone instead of DateTime
 - Make sure to validate fields in a Rails model to be nil
 - For AJAX forms add a separate authenticity token for each form
 - Didn't check fig.yml for development or production