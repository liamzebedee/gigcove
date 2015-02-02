angular.module('app', ['ionic'])
.controller('NewGigCtrl', function($scope, $ionicModal, $http) {
  
  $ionicModal.fromTemplateUrl('selectVenueModal.html', {
    scope: $scope,
    animation: 'slide-in-up'
  }).then(function(modal) {
    $scope.selectVenueModal = modal;    
  });

  $ionicModal.fromTemplateUrl('tagsModal.html', {
      scope: $scope,
      animation: 'slide-in-up'
  }).then(function(modal){
    $scope.tagsModal = modal;
  });

  $scope.gig = {};
  $scope.gig.tags = [];
  $scope.gig.venue = {
    name: "",
    location: "",
    id: null
  };

  // Tags
  $scope.searchTags = { query: "" };
  $scope.createTag = function(tagName) {
    var newTag = {
      name: tagName
    };
    $scope.addTag(newTag);
    $scope.searchTags.query = "";
  };
  $scope.hasTag = function(tag) {
    var hasTag = false;
    $.each($scope.gig.tags, function(index, value){
      if(value.name === tag.name) { return (hasTag = true); }
    });
    return hasTag;
  };
  $scope.addTag = function(tag) {
    $scope.gig.tags.push(tag);
  };
  $scope.removeTag = function(tag) {
    $.each($scope.gig.tags, function(index, value){
      if(value.name === tag.name) { $scope.gig.tags.splice(index, 1); }
    });
  };


  // Venues
  $scope.searchVenues = {
    loadedVenues: [],
    query: "",
    searching: false
  };
  $scope.runVenueSearch = function() {
    $scope.searchVenues.searching = true;
    $http.get('/venues.json/', {
      params: { name: $scope.searchVenues.query }
    }).
    success(function(data, status, headers, config) {
      $scope.searchVenues.loadedVenues = data;
      $scope.searchVenues.searching = false;
    }).
    error(function(data, status, headers, config) {
      $scope.searchVenues.searching = false;
    });
  }
  $scope.$watch('searchVenues.query', function(newQuery, oldQuery) {
    $scope.runVenueSearch();
  });
  $scope.selectVenue = function(venue){
    $scope.gig.venue = venue;
    $scope.searchVenues.query = "";
    $scope.selectVenueModal.hide();
  };
  $scope.createVenue = function(venueName){
    $scope.gig.venue.name = venueName;
    $scope.searchVenues.query = "";
    $scope.selectVenueModal.hide();
  }

});