// So this works with turbolinks
var ready = function(){
	$(".chosen-select").chosen({width: "100%"});
	
	$("[contenteditable=true]").contentEditable();
	
	
	//on submit, collect all fields and replace their values into the hidden inputs
	$(".gig-form").submit(function(event) {
		// Set variables
		var ticketCost = $('.ticket-cost', this).text();
		if(ticketCost == "") {
			$('.ticket-cost', this).createPopover('How much does entry cost?');
			return false;
		}
		function getDatetime(fromOrTwo) {
			var year = 2000 + parseInt( $('.'+fromOrTwo+'-date-year').text() );
			return new Date( year, parseInt( $('.'+fromOrTwo+'-date-month').text() ) - 1, parseInt( $('.'+fromOrTwo+'-date-day').text() ), parseInt( $('.'+fromOrTwo+'-time-hour').text() ), parseInt( $('.'+fromOrTwo+'-time-minute').text() ) ).getTime()/1000;
		}
		var from = getDatetime('from');
		if(isNaN(from)) { 
			$('.from-date-month', this).createPopover('When does the gig start?');
			return false;
		}
		var to = getDatetime('to');
		if(isNaN(to)) {
			$('.to-date-month', this).createPopover('When does the gig end?');
			return false;
		}
		var eventName = $('.event-name', this).text();
		var venueName = $('.venue-name', this).text();
		if(venueName == "") {
			$('.venue-name', this).createPopover("What's the name of the venue?");
			return false;
		}
		/*var genres = [];
		$('.search-choice').each(function(){
			genres.push($(this).text());
		});*/
		var location = $('.location', this).text();
		if(location == "") {
			$('.location', this).createPopover("Where is the gig at?");
			return false;
		}
		
		$('#gig_ticket_cost', this).val(ticketCost);
		$('#gig_from', this).val(from);
		$('#gig_to', this).val(to);
		$('#gig_event_name', this).val(eventName);
		$('#gig_venue_name', this).val(venueName);
		//$('#gig_genres', this).val(genres.toString());
		$('#gig_location', this).val(location);
	});
	
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
