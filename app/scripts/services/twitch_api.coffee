angular.module 'blimp'
  .factory 'TwitchApi', ($http) ->

    BASE_URL = 'https://api.twitch.tv/kraken'

    class TwitchApi

      fetchHighlights: (channelName, batchSize, offset) ->
        $http.jsonp("#{BASE_URL}/channels/#{channelName}/videos",
          params:
            limit: batchSize
            offset: offset
            callback: 'JSON_CALLBACK'
        ).then (response) ->
          response.data
