// So this works with turbolinks
var ready = function(){	
	$("[contenteditable=true]").contentEditable();
	
	$(".gig-approve-form").on("ajax:success", function(e, data, status, xhr){
		$(this).parents('.gig-row').addClass('moderated');
		$('button', this).attr('disabled', 'disabled');
	}).bind("ajax:error", function(e, xhr, status, error){
    	
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);
