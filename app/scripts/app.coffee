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
    'ngRoute',
    'ngMaterial',
    'infinite-scroll',
  ]
  .config ($mdThemingProvider) ->
    $mdThemingProvider.theme 'default'
      .primaryPalette('brown')
      .accentPalette('amber')
