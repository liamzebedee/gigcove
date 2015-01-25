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
  $scope.loadedTags = [
    { name: "dance", description: "Something something dark side of the moon", added: false },
    { name: "heyhey", description: "Crazy 123", added: false }
  ];

  // Tags
  $scope.hasTag = function(tag) {
    return $.inArray($scope.gig.tags, {name: tag.name}) !== -1;
  };
  $scope.addTag = function(tag) {
    $scope.gig.tags.push({name: tag.name});
    tag.added = true;
  };
  $scope.removeTag = function(tag) {
    $.each($scope.gig.tags, function(index, value){
      if(value.name === tag.name) { $scope.gig.tags.splice(index, 1); }
    });
    tag.added = false;
  };
});