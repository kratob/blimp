'use strict'

###*
 # @ngdoc overview
 # @name brexSearchApp
 # @description
 # # brexSearchApp
 #
 # Main module of the application.
###
angular
  .module 'brexSearchApp', [
    'ngAnimate',
    'ngAria',
    'ngResource',
    'ngRoute'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'
      .otherwise
        redirectTo: '/'

