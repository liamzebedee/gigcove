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

  $scope.tags = [];
  $scope.loadedTags = [
    { name: "dance", description: "Something something dark side of the moon" },
    { name: "dance", description: "Something something dark side of the moon" },
    { name: "dance", description: "Something something dark side of the moon" }
  ];
  $scope.venue = {
    name: "boop",
    location: "12 asdas st"
  };

  // Tags
  $scope.changeTag = function(tag) {
    /*if($scope.tags.contains(tag)) remove;
    else addTag(tag);
    $scope.tags.push(tag);*/
  };
  $scope.removeTag = function(tag) {
    // TODO
  };
});

var ready = function(){
  // Bootstrap Angular here because stuff with Turbolinks
  // http://stackoverflow.com/questions/14797935/using-angularjs-with-turbolinks
  angular.bootstrap(document.body, ['app']);

	$("[contenteditable=true]").contentEditable();
};

$(document).ready(ready);
$(document).on('page:load', ready);

// NProgress
$(document).on('page:fetch',   function() { NProgress.start(); });
$(document).on('page:change',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });