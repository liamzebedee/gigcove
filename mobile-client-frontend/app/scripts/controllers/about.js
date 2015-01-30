'use strict';

/**
 * @ngdoc function
 * @name dualNodeApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the dualNodeApp
 */
angular.module('dualNodeApp')
  .controller('AboutCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
