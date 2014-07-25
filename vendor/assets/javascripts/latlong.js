(function($) {
	$.getLatLng = function(){
		var data = {
			latitude: null,
			longitude: null
		};
		window.navigator.geolocation.getCurrentPosition(function(position){
			data.latitude = position.coords.latitude;
			data.longitude = position.coords.longitude;
			if(position.coords.longitude == null || position.coords.latitude == null) data = null;
			return data;
		});
	};
})(jQuery);
