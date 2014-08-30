$(document).on('ready page:load', function () {
	function tokenInput(element, options_given) {
		var prePopulateData = element.attr('value') || "";
		var prePopulate = [];
		if(prePopulateData.length > 0) {
			var names = prePopulateData.split(',');
			for(var i = 0; i < names.length; i++) {
				prePopulate.push({name: names[i]});
			}
		}
		
		var options = {
			queryParam: "search",
			searchDelay: 150,
			placeholder: element.attr('placeholder'),
			// Prepopualte data stored in value attr, doesn't include ids because we don't need them
			prePopulate: prePopulate
		};
		$.extend(options, options_given);
		element.tokenInput(element.data("ajax"), options);
	}

	var gigGenres = $(".gig-editable .gig-genres");
	var gigVenue = $(".gig-editable .gig-venue");
	tokenInput(gigGenres, {
		searchDelay: 100
	});
	tokenInput($('.gig-venue-name', gigVenue), {
		searchDelay: 200,
		tokenLimit: 1,
		allowFreeTagging: true,
		onFreeTaggingAdd: function(hidden_input, token) {
			$('.gig-venue-location', gigVenue).show();
			return hidden_input;
		}
	});

	var gigArtists = $(".gig-editable .gig-artists");
	tokenInput(gigArtists, {
		allowFreeTagging: true,
		noResultsText: "No artists found - you can add this new artist by pressing [enter]",
		searchDelay: 300
	});

	// initialize input widgets first
	$('.gig-editable .gig-times .input-time').timepicker({
		'showDuration': true,
		'timeFormat': 'g:ia'
	});

	$('.gig-editable .gig-times .input-date').datepicker({
		'format': 'd/m/yyyy',
		'autoclose': true
	});

	// initialize datepair
	$('.gig-editable .gig-times').datepair();




	// on submit, collect all fields and replace their values into the hidden inputs
	$(".gig-form").submit(function(event) {
		event.preventDefault();
		var gig = this;

		// Set variables
		// -------------
		var ticketCost = $('.ticket-cost', gig).text();
		if(ticketCost == "") {
			ticketCost = 0;
		}

		function getDatetimeForPicker(date, time) {
			return moment(date + ' ' + time, 'D/M/YYYY hh:mma').zone(new Date().getTimezoneOffset()).toISOString();
		}
		var startDate = $('.gig-times .input-date.start').val();
		var startTime = $('.gig-times .input-time.start').val();
		var startDatetime = getDatetimeForPicker(startDate, startTime);
		if(startDate == "") {
			$('.gig-times .input-date.start', gig).createPopover('What day is the gig?');
			return false;
		}
		if(startTime == "") { 
			$('.gig-times .input-time.start', gig).createPopover('When does the gig start?');
			return false;
		}

		var endTime = $('.gig-times .input-time.end').val();
		var endDatetime = getDatetimeForPicker(startDate, endTime);
		if(endTime == "") {
			$('.gig-times .input-time.end', gig).createPopover('When does the gig end?');
			return false;
		}

		var venueNameJQ = ($(".gig-venue-name", gig).tokenInput("get"));
		var venueName;
		if(venueNameJQ.length == 0 || venueNameJQ[0].name == "") {
			$('.gig-venue-name', gig).createPopover("What venue is the gig at?");
			return false;
		} else {
			venueName = venueNameJQ[0].name;
		}

		var venueLocationJQ = $(".gig-venue-location", gig);
		var venueLocation = venueLocationJQ.text();
		if(!venueLocationJQ.is(":hidden") && venueLocation == "") {
			venueLocationJQ.createPopover("Where is the venue?");
			return false;
		}

		var title = $(".gig-title", gig).text();
		if(title == "") {
			$(".gig-title", gig).createPopover("What is the title of the gig?");
			return false;
		}

		var linkToSource = $(".link-to-source", gig).text();

		var description = $(".description", gig).val();

		var genres = [];
		var genresTokenInput = $('.gig-genres', gig).tokenInput("get");
		if(genresTokenInput.length == 0) {
			$('.gig-genres', gig).parent().find('#token-input-').createPopover("What types of music will be played?");
			return false;
		}
		for(var i = 0; i < genresTokenInput.length; i++) {
			genres.push(genresTokenInput[i].name);
		}

		var performances = [];
		var performancesTokenInput = $('.gig-artists', gig).tokenInput("get");
		if(performancesTokenInput.length == 0) {
			$('.gig-artists', gig).parent().find('#token-input-').createPopover("Who will be playing?");
			return false;
		}
		for(var i = 0; i < performancesTokenInput.length; i++) {
			performances.push(performancesTokenInput[i].name);
		}


		// Fill in hidden inputs
		// ---------------------
		$('#gig_ticket_cost', gig).val(ticketCost);
		$('#gig_start_time', gig).val(startDatetime);
		$('#gig_end_time', gig).val(endDatetime);
		$('#venue_name', gig).val(venueName);
		$('#venue_location', gig).val(venueLocation);
		$('#gig_title', gig).val(title);
		$('#gig_link_to_source', gig).val(linkToSource)
		$('#gig_description', gig).val(description);
		$('#gig_genres', gig).val(genres);
		$('#gig_performances', gig).val(performances);

		$(this)[0].submit();
	});
});