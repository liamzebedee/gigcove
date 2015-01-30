$(document).on('ready page:load', function () {
	$('.gig-form').each(function(index, gigForm){
		function tokenInput(element, options_given) {
			var prePopulateData = $(element).attr('value') || "";
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
				placeholder: $(element).attr('placeholder'),
				// Prepopulate data stored in value attr, doesn't include ids because we don't need them
				prePopulate: prePopulate
			};
			$.extend(options, options_given);
			$(element).tokenInput($(element).data("ajax"), options);
		}
		
		var gigGenres = $(".gig-genres", gigForm);
		tokenInput(gigGenres, {
			searchDelay: 50
		});

		var gigVenue = $(".gig-venue", gigForm);
		tokenInput($('.gig-venue-name', gigVenue), {
			searchDelay: 200,
			tokenLimit: 1,
			allowFreeTagging: true,
			onFreeTaggingAdd: function(hidden_input, token) {
				$('.new-venue-info', gigVenue).show();
				return hidden_input;
			},
			onDelete: function() {
				$('.new-venue-info', gigVenue).hide();
			}
		});

		var gigArtists = $(".gig-artists", gigForm);
		tokenInput(gigArtists, {
			allowFreeTagging: true,
			noResultsText: "No artists found - you can add this new artist by pressing [enter]",
			searchDelay: 300
		});








		// initialize input widgets first
		$('.gig-times .input-time', gigForm).timepicker({
			'showDuration': true,
			'timeFormat': 'g:ia'
		}).on('changeTime', function(e){
			// TODO XXX DIRTY HACK
			$(this).text($(this).data('ui-timepicker-value'));
		});


		$('.gig-times .input-date', gigForm).datepicker({
			'format': 'd/m/yyyy',
			'autoclose': true
		}).on('changeDate', function(e){
			var dateFormatted = e.format(0); // 0 = first date
			$(this).text(dateFormatted);
		});

		// initialize datepair
		$('.gig-times', gigForm).datepair();

		var coverImageFileInput = $('#venue_cover_image', gigForm);
		var coverImageSelectButton = $('#venue-select-cover-image', gigForm);
		coverImageSelectButton.click(function(){
			coverImageFileInput.click();
		});
		coverImageFileInput.change(function(){
			var files = coverImageFileInput.prop('files');
			if(files.length > 0) {
				coverImageSelectButton.text(files[0].name);
			}
			coverImageSelectButton.blur();
		});

	});









	// on submit, collect all fields and replace their values into the hidden inputs
	$(".gig-form").submit(function(event) {
		event.preventDefault();
		var gig = this;
		var isModerationForm = $(this).hasClass('gig-approve-form');

		// Set variables
		// -------------
		var ticketCost = $('.ticket-cost', gig).text();
		if(ticketCost == "") {
			ticketCost = 0;
		}

		function getDatetimeForPicker(date, time) {
			return moment(date + ' ' + time, 'D/M/YYYY hh:mma').toISOString();
		}
		var startDate = $('.gig-times .input-date.start').text();
		var startTime = $('.gig-times .input-time.start').text();
		var startDatetime = getDatetimeForPicker(startDate, startTime);
		if(startDate == "") {
			$('.gig-times .input-date.start', gig).createPopover('What day is the gig?');
			return false;
		}
		if(startTime == "") { 
			$('.gig-times .input-time.start', gig).createPopover('When does the gig start?');
			return false;
		}

		var endTime = $('.gig-times .input-time.end').text();
		var endDatetime = getDatetimeForPicker(startDate, endTime);
		if(endTime == "") {
			$('.gig-times .input-time.end', gig).createPopover('When does the gig end?');
			return false;
		}

		var venueNameJQ;
		var venueName;
		var venueId;
		var venueLocationJQ;
		var venueLocation;

		if(!isModerationForm) {
			var venueNameJQ = $(".gig-venue-name", gig).tokenInput("get");
			var venueName;
			var venueId;
			if(venueNameJQ.length == 0 || venueNameJQ[0].name == "") {
				$('.gig-venue-name', gig).createPopover("What venue is the gig at?");
				return false;
			} else if($(".new-venue-info").is(":hidden")) {
				// Preexisting venue, just use id
				venueId = venueNameJQ[0].id;
			} else {
				venueName = venueNameJQ[0].name;
			}

			var venueLocationJQ = $(".gig-venue-location", gig);
			var venueLocation = venueLocationJQ.text();
			if(!venueLocationJQ.is(":hidden") && venueLocation == "") {
				venueLocationJQ.createPopover("Where is the venue?");
				return false;
			}
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
		$('#venue_id', gig).val(venueId);
		$('#gig_title', gig).val(title);
		$('#gig_link_to_source', gig).val(linkToSource)
		$('#gig_description', gig).val(description);
		$('#gig_genres', gig).val(genres);
		$('#gig_performances', gig).val(performances);

		// Get form element of JQuery object
		if(isModerationForm) {
			// AJAX
			$(this).trigger('submit.rails');
		} else {
			// Normal
			$(this)[0].submit();
		}		
	});
});