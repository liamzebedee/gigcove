angular.module('app', ['ionic'])
.controller('NewGigCtrl', function($scope, $ionicModal) {
  $ionicModal.fromTemplateUrl('my-modal.html', {
    scope: $scope,
    animation: 'slide-in-up'
  }).then(function(modal) {
    $scope.modal = modal;
  });


});

var ready = function(){	
	$("[contenteditable=true]").contentEditable();
	$('span[type="number"]').numeric();
	
	$('.timepicker').pickatime();
	
	
	$(".gig-approve-form").on("ajax:success", function(e, data, status, xhr){
		$(this).parents('.gig-row').addClass('moderated');
		$('button', this).attr('disabled', 'disabled');
	}).bind("ajax:error", function(e, xhr, status, error){
    	
    });

  
    

  $('a[role=modal]').on('touchstart click', function(event) {
  	event.stopPropagation(); event.preventDefault();
  	if(event.handled !== true) {

    var modal = $($(this).attr('href'));
    modal.toggleClass('hide');
    $('#modal-wrapper', modal).toggleClass('active');
                event.handled = true;
  }
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);

// NProgress
$(document).on('page:fetch',   function() { NProgress.start(); });
$(document).on('page:change',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });