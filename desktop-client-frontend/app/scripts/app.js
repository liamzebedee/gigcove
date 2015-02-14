'use strict';

/**
 * Main module of the application.
 */
angular
  .module('app', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });


if(!Modernizr.inputtypes.date) {
  $('input[type=date]').combodate({
    minYear: new Date().getFullYear(),
    maxYear: new Date().getFullYear() + 1,
    format: "DD/MM/YYYY",
    template: "D MMM YYYY",
    yearDescending: false,
    smartDays: true
  });
}
if(!Modernizr.inputtypes.time) {
  $('input[type=time]').combodate({
    format: "h:mm a",
    template: "h : mm a",
    minuteStep: 1
  });
}