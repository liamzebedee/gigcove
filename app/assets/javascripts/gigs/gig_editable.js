$(document).on('ready page:load', function () {
	function tokenInput(element, options_given) {
		var options = {
			queryParam: "search",
			searchDelay: 150,
			placeholder: element.attr('placeholder')
		};
		$.extend(options, options_given);
		element.tokenInput(element.data("ajax"), options);
	}

	var gigGenres = $(".gig-genres");
	var gigVenue = $(".gig-venue-name");
	tokenInput(gigGenres, {
		searchDelay: 100
	});
	tokenInput(gigVenue, {
		searchDelay: 200
	});

	var gigArtists = $(".gig-artists");
	tokenInput(gigArtists, {
		allowFreeTagging: true,
		noResultsText: "No artists found - you can add this new artist by pressing [enter]",
		searchDelay: 300
	});

	$(".gig-times")
// initialize input widgets first
$('.gig-times .input-time').timepicker({
'showDuration': true,
'timeFormat': 'g:ia'
});

$('.gig-times .input-date').datepicker({
'format': 'd/m/yyyy',
'autoclose': true
});

// initialize datepair
$('.gig-times').datepair();


});