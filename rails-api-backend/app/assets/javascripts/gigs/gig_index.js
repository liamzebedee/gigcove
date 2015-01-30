$(document).on('ready page:load', function () {
    if($("#gigs-index").length) {
        window.navigator.geolocation.getCurrentPosition(function(position) {
            $('.search-gigs #search_latitude').val(position.coords.latitude);
            $('.search-gigs #search_longitude').val(position.coords.longitude);
        });
    }

    $(".search-gigs button").click(function(event) {
    	var form = $(this).parents('.search-gigs');
    	var location = $(".location", form).text();
    	var maxTicketCost = $(".max-ticket-cost", form).text();

    	var needToPromptForLocation = ($('#search_latitude', form).val() && $('#search_latitude', form).val()) == "" ? true : false;
        if(needToPromptForLocation) {
            $('.location').createPopover('Where are you right now?');
            return true;
        } else {
            $('#search_location', form).val(location);
            $('#search_max_ticket_cost', form).val(maxTicketCost);
            form.submit();
        }

    	return false;
    });
    
    (function(){
    	var ladda = Ladda.create($('.search-gigs button[type="submit"]')[0]);
		$(".search-gigs").on("ajax:before", function(){
			ladda.start();
		});
		$('.search-gigs').on("ajax:complete", function(){
		 	ladda.stop();
		});
    })();
});