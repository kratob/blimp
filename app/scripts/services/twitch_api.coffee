angular.module 'blimp'
  .factory 'TwitchApi', ($http, $q) ->

    BASE_URL = 'https://api.twitch.tv/kraken'

    class TwitchApi

      fetchHighlights: (channelName, batchSize, offset) ->
        $http.jsonp("#{BASE_URL}/channels/#{channelName}/videos",
          params:
            limit: batchSize
            offset: offset
            callback: 'JSON_CALLBACK'
        ).then (response) ->
          if response.data.error?
            $q.reject(response.data.message)
          else
            response.data
