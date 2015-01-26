angular.module('app', ['ionic'])
.controller('NewGigCtrl', function($scope, $ionicModal) {
  
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
    name: "boop",
    location: "12 asdas st"
  };


  $scope.loadedVenues = [];
  $scope.searchTagQuery = { q: "" };

  // Tags
  $scope.createTag = function(tagName) {
    var newTag = {
      name: tagName
    };
    $scope.addTag(newTag);
    $scope.searchTagQuery.q = "";
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
});