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
    'ngRoute'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/:channelName',
        templateUrl: 'views/channel.html'
        controller: 'ChannelCtrl'
        controllerAs: 'channel'
      .otherwise
        redirectTo: '/bananasaurus_rex'

