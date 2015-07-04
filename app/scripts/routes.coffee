angular
  .module 'blimp'
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/dashboard.html'
        controller: 'DashboardCtrl'
        controllerAs: 'dashboard'
      .when '/:channelName',
        templateUrl: 'views/channel.html'
        controller: 'ChannelCtrl'
        controllerAs: 'channel'
      .otherwise
        redirectTo: '/'

