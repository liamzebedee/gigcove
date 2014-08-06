// So this works with turbolinks
var ready = function(){	
	$("[contenteditable=true]").contentEditable();
	
	$(".gig-approve-form").on("ajax:success", function(e, data, status, xhr){
		$(this).parents('.gig-row').addClass('moderated');
		$('button', this).attr('disabled', 'disabled');
	}).bind("ajax:error", function(e, xhr, status, error){
    	
    });
    
    $(".search-gigs button").click(function(event) {
    	var form = $(this).parents('.search-gigs');
    	var location = $(".location", form).text();
    	var maxTicketCost = $(".max-ticket-cost", form).text();
    	var latitude, longitude;
    	var needToPromptForLocation = false;
    	
    	window.navigator.geolocation.getCurrentPosition(function(position) {
    		latitude = position.coords.latitude;
    		longitude = position.coords.longitude;
    		
			if(!latitude && location == "") {
				needToPromptForLocation = true;
			}
			finalbit();
    	}, function(){
    		// Error condition
    		console.log(location);
    		if(location == "") {
    			needToPromptForLocation = true;
    		}
    		finalbit();
    	});
    	
    	function finalbit() {
			if(needToPromptForLocation) {
				$('.location').createPopover('Where are you right now?');
			} else {
				console.log('submit');
				$('#search_location', form).val(location);
				$('#search_max_ticket_cost', form).val(maxTicketCost);
				$('#search_latitude', form).val(latitude);
				$('#search_longitude', form).val(longitude);
				form.submit();
			}
    	}
    	
    	return false;
    });
    
    (function(){
    	var l = Ladda.create($('.search-gigs button[type="submit"]')[0]);
		$(".search-gigs").on("ajax:before", function(){
			l.start();
		});
		$('.search-gigs').on("ajax:complete", function(){
		 	l.stop();
		});
    })();
    
};

$(document).ready(ready);
$(document).on('page:load', ready);
