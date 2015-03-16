angular.module('app').
controller('AppCtrl', function($scope, uiGmapGoogleMapApi, $timeout, $http) {
    $scope.search = {
        location: "Sydney, AU",
        location_lat: null,
        location_lng: null,
        cost: 25,
        under_18: false,
        fromDatePretty: "today",
        fromDate: "",
        tillDatePretty: "next week",
        tillDate: "",
        isSearchingForGigs: false
    };

    $scope.search.searchForGigs = function() {
        $scope.search.isSearchingForGigs = true;

        var searchParams = {
            cost: $scope.search.cost,
            distance_radius: 60,
            latitude: $scope.search.location_lat,
            longitude: $scope.search.location_lng
        };

        $http.get('/api/gigs', { params: { q: JSON.stringify(searchParams) } }).success(function(){
            $scope.search.gigs = response;
        });
    };

    $scope.$watch('search.fromDatePretty', function(newValue, oldValue) {
        $scope.search.fromDate = Date.create(newValue).format(Date.ISO8601_DATETIME);
    });
    $scope.$watch('search.tillDatePretty', function(newValue, oldValue) {
        $scope.search.tillDate = Date.create(newValue).format(Date.ISO8601_DATETIME);
    });
    $scope.$watch('search.location', function(newValue, oldValue){
        updateLatLngFromLocation(newValue);
    });

    function updateLatLngFromLocation(location) {
        uiGmapGoogleMapApi.then(function(maps) {
            geocoder = new maps.Geocoder();
            geocoder.geocode({
                'address': location
            }, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    var latlng = results['geometry'].location;
                    $scope.search.location_lat = latlng.lat();
                    $scope.search.location_lng = latlng.lng();
                } else {

                }
            });
        });
    }

    // get user latlng
    // geolocate to address
    // allow user to change address
    uiGmapGoogleMapApi.then(function(maps) {
        var initialLocation = null;
        if (navigator.geolocation) {
            browserSupportFlag = true;
            navigator.geolocation.getCurrentPosition(function(position) {
                initialLocation = new maps.LatLng(position.coords.latitude, position.coords.longitude);
                $scope.search.location_lat = position.coords.latitude;
                $scope.search.location_lng = position.coords.longitude;
                geocoder = new maps.Geocoder();
                geocoder.geocode({
                    'latLng': initialLocation
                }, function(results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var city = results[1]["formatted_address"];
                        $.each(results[1]["address_components"], function(index, value) {
                            if (_.includes(value['types'], 'locality')) {
                                city = value['long_name'];
                            }
                        });
                        $scope.search.location = city;
                        $scope.$apply();
                    }
                });
            }, function() {
                // fail to navigator.geolocation.getCurrentPosition
            });
        }
    });
});