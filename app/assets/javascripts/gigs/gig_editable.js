$(document).on('ready page:load', function () {
	function tokenInput(element) {
		element.tokenInput(element.data("ajax"), {
			queryParam: "search",
			searchDelay: 150,
			placeholder: element.attr('placeholder')
		});
	}

	var gigGenres = $(".gig-genres");
	var gigVenue = $(".gig-venue-name");
	tokenInput(gigGenres);
	tokenInput(gigVenue);

	function addNewArtistItem(artists) {		
		var cloned = $('li', artists).first().clone();
		// Remove contenteditable
		$('[contenteditable]', cloned).each(function(i, element){
			$(element).text("");
		});

		artists.append(cloned);
	}

	$(".gig-artists button").mouseup(function() {
		addNewArtistItem($(this).parent('.gig-artists'));
	});
});