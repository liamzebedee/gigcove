var ready = function(){
  // Bootstrap Angular here because stuff with Turbolinks
  // http://stackoverflow.com/questions/14797935/using-angularjs-with-turbolinks
  angular.bootstrap(document.body, ['app']);

  if(!Modernizr.inputtypes.date) {
  	$('input[type=date]').combodate({
  		minYear: new Date().getFullYear(),
  		maxYear: new Date().getFullYear() + 1,
  		format: "DD/MM/YYYY",
  		template: "D MMM YYYY",
  		yearDescending: false,
  		smartDays: true
  	});
  }
  if(!Modernizr.inputtypes.time) {
  	$('input[type=time]').combodate({
  		format: "h:mm a",
  		template: "h : mm a",
  		minuteStep: 1
  	});
  }
};

$(document).ready(ready);
$(document).on('page:load', ready);

// NProgress
$(document).on('page:fetch',   function() { NProgress.start(); });
$(document).on('page:change',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });