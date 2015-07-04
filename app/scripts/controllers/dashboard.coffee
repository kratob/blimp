angular.module 'blimp'
  .controller 'DashboardCtrl', ($location) ->
    @goTo = (channelName) ->
      return if !channelName? || channelName == ''
      $location.path("/#{channelName}")

    return
