'use strict';

/**
 * @ngdoc function
 * @name dualNodeApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the dualNodeApp
 */
angular.module('app')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
