$(document).on('ready page:load', function () {
	var gigGenres = $(".gig-genres");
	gigGenres.tokenInput(gigGenres.data("ajax"), {
		queryParam: "search",
		searchDelay: 150,
		placeholder: gigGenres.attr('placeholder')
	});

	var gigVenues = $(".gig-venues");
	gigVenues.tokenInput(gigVenues.data("ajax"), {
		queryParam: "search",
		searchDelay: 150,
		placeholder: gigVenues.attr('placeholder')
	});
	
	/*.chosen({
		width: "100%",
		ajax: {
			url: $(this).data("remote"),
			dataType: 'jsonp',
			data: function (term) {
				return { q: term };
			},
			results: function (data) {
				genre_names = [];
				for(var item in data) {
					genre_names += item.name;
				}
				return { results: genre_names };
			}
		}
	});*/
});

/*$('.chosen-choices input').autocomplete({
  source: function( request, response ) {
    $.ajax({
      url: this.form_field.options.ajax.url,
      dataType: this.form_field.options.ajax.dataType,
      beforeSend: function(){$('ul.chosen-results').empty();},
      success: function( data ) {
        response( $.map( this.form_field.options.ajax.results(data), function( item ) {
          $('ul.chosen-results').append('<li class="active-result">' + item + '</li>');
        }));
      }
    });
  }
});*/
