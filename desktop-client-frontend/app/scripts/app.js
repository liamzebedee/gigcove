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
        'contenteditable'
    ])
    .config(function($routeProvider, uiGmapGoogleMapApiProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'views/home.html',
                controller: 'HomeCtrl'
            })
            .when('/post-a-gig', {
                templateUrl: 'views/post-gig.html',
                controller: 'PostGigCtrl'
            })
            .when('/find-gigs', {
                templateUrl: 'views/find-gigs.html',
                controller: 'FindGigsCtrl'
            })
            .otherwise({
                redirectTo: '/'
            });

        uiGmapGoogleMapApiProvider.configure({
            key: 'AIzaSyAhoPz9OZXiBiOWoJ53jwgBc8bOaxvcyDw',
            v: '3.18',
            libraries: ''
        });

    });