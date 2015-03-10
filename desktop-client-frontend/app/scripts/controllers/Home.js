angular.module('app')
.controller('HomeCtrl', function($scope, uiGmapGoogleMapApi) {
    $('.ui.checkbox').checkbox();

	$scope.search = {
		location: "Sydney, AU",
		cost: 25,
		under_18: false
	};

	// get user latlng
	// geolocate to address
	// allow user to change address
	uiGmapGoogleMapApi.then(function(maps) {
	var initialLocation = null;
	if(navigator.geolocation) {
	    browserSupportFlag = true;
	    navigator.geolocation.getCurrentPosition(function(position) {
	      initialLocation = new maps.LatLng(position.coords.latitude,position.coords.longitude);
	      geocoder = new maps.Geocoder();
	      geocoder.geocode({'latLng': initialLocation}, function(results, status) {
    	  	if (status == google.maps.GeocoderStatus.OK) {
    	  		var city = results[1]["formatted_address"];
    	  		$.each(results[1]["address_components"], function(index, value){
    	  			if(_.includes(value['types'], 'locality')) {
    	  				city = value['long_name'];
    	  			}
    	  		});
    	  		$scope.search.location = city;
    	  	}
    	  });
	    }, function() {
	      // fail
	    });
	}
});

});