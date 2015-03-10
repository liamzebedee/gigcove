angular.module('app').controller('HomeCtrl', function($scope, uiGmapGoogleMapApi) {
    $('.ui.checkbox').checkbox();
    $('.datepicker').pickadate({
    	closeOnSelect: true,
		closeOnClear: true
    });
});