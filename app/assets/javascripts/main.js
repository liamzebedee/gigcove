var ready = function(){
  // Bootstrap Angular here because stuff with Turbolinks
  // http://stackoverflow.com/questions/14797935/using-angularjs-with-turbolinks
  angular.bootstrap(document.body, ['app']);

	$("[contenteditable=true]").contentEditable();
};

$(document).ready(ready);
$(document).on('page:load', ready);

// NProgress
$(document).on('page:fetch',   function() { NProgress.start(); });
$(document).on('page:change',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });