// So this works with turbolinks
var ready = function(){	
	$("[contenteditable=true]").contentEditable();
	$('span[type="number"]').numeric();
	
	
	$(".gig-approve-form").on("ajax:success", function(e, data, status, xhr){
		$(this).parents('.gig-row').addClass('moderated');
		$('button', this).attr('disabled', 'disabled');
	}).bind("ajax:error", function(e, xhr, status, error){
    	
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);


// Nprogress
$(document).on('page:fetch',   function() { NProgress.start(); });
$(document).on('page:change',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });