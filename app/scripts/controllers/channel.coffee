'use strict'

###*
 # @ngdoc function
 # @name brexSearchApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the brexSearchApp
###
angular.module 'brexSearchApp'
  .controller 'ChannelCtrl', ($routeParams, Channel) ->
    @channelName = $routeParams.channelName
    @channel = new Channel(@channelName)
    @channel.update()
    @channel.allReady.then =>
      @highlights = @channel.highlights
      @results = @highlights

    @filter = (query) ->
      query = query.toLowerCase()
      if query == ''
        @results = @highlights
      else
        @results = _.filter @highlights, (highlight) ->
          highlight.matches(query)


    return
