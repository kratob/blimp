angular.module 'brexSearchApp'
  .controller 'DashboardCtrl', ($location) ->
    @goTo = (channelName) ->
      console.log(channelName)
      return if !channelName? || channelName == ''
      $location.path("/#{channelName}")

    return
