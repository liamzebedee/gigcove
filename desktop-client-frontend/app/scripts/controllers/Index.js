angular.module('app')
.controller('IndexCtrl', function($scope, uiGmapGoogleMapApi) {
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
    	  		$scope.search.location = results[1].formatted_address;
    	  	}
    	  });
	    }, function() {
	      // fail
	    });
	}
});

});