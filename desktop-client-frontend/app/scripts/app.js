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
        'ngTouch',
        'uiGmapgoogle-maps',
        'contenteditable',
        'datePicker',
        // 'ui.bootstrap.datetimepicker',

        'sessionService'
    ])
    .config(function($routeProvider, uiGmapGoogleMapApiProvider, $httpProvider, $locationProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'views/home.html',
                controller: 'HomeCtrl'
            })
            .when('/users/login', {
                templateUrl: 'views/login.html',
                controller: 'UserCtrl'
            })
            .when('/moderate-gigs', {
                templateUrl: 'views/moderate-gigs.html',
                controller: 'ModerateGigsCtrl'
            })
            .when('/post-a-gig', {
                templateUrl: 'views/post-gig.html',
                controller: 'PostGigCtrl'
            })
            .otherwise({
                templateUrl: 'views/home.html',
                controller: 'HomeCtrl'
            });

        uiGmapGoogleMapApiProvider.configure({
            key: 'AIzaSyAhoPz9OZXiBiOWoJ53jwgBc8bOaxvcyDw',
            v: '3.18',
            libraries: ''
        });

        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('head meta[name=csrf-token]').attr('content');
        //$locationProvider.html5Mode(true);

    });