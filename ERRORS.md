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
 - Get an error with calling a method in a .js.erb.jsx file. Asset pipeline reports error in calling route helper method while processing ERB, which has previously worked with the same code. Obvious error is found elsewhere. Commented out code and recompiled in a separate `fig up` and it worked. Visited in browser and encountered React::Renderer::PrerenderError. http://stackoverflow.com/questions/6725629/route-helpers-in-asset-pipeline?rq=1 - found syntax errors in JSX. Fixed those errors. 
   
   Now back to the same issue. **/railsapp/app/assets/javascripts/components/GigSearchForm.js.jsx.erb:44:in `block in singleton class': undefined method gigs_path for #<Module:0x007f83693d3468> (NoMethodError)** - for some reason erb_helpers.rb initializer which is supposed to include the route helpers module in ERB is not working. THE FIX is to insert a fake load of the module in the JSX <%= <%= Rails.application.routes.url_helpers %> and then load the app, it compiles fine and renders. Then add the route helper at the end at and that works. Okay, maybe now that the module is loaded we can access the methods now, is that it? No, I then restart the server by running `fig up`. It works yet again, counterintuitively since I had the same code as when I originally started. The saga continues...

 - I was showing a modal on a link being clicked using some JQuery selectors. I detected this for mobile by also handling the touchend event, and I did both in one event selector. However I noticed that when I was testing this in Chrome developer tools (with responsive design and touch simulation), the modal would open and then quickly disappear. I realised that this is because I was using toggleClass('hide') and that it was handling the click event first and then because of touch event simulation (with its 300ms delay) the touchend event later, thereby showing and then encore hiding the element.
 - Never try to work against the framework/library. Tried implementing the Ionic modal dialog without using Angular JS. Took 4 hours when I could've spent 20 minutes just including it.
 - If it takes a while, just try thinking of another approach that might be more performance-intensive or less efficient but actually works. Because an approach that works is an approach that works, and is always the most efficient approach because it is the only one that works.
 - Before you even start using a framework, search for the most common mistakes and pitfalls. AngularJS has this thing where you need to have complex objects in order for the scope to function in a manner that is intuitive.
 - AngularJS will not run the method ng-click="doSomething" as it has no parentheses. It treats it as an expression about a variable, not a method.
 - Ionic doesn't scroll on iOS when you have forms and labels, because they divert the attention.
 - Ionic doesn't highlight text on mobile or desktop, as it is detecting touch events etc.