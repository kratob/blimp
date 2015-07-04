angular.module 'brexSearchApp'
  .factory 'Channel', (LsCache, TwitchApi, Highlight, $q, $timeout) ->
    BATCH_SIZE = 100
    UPDATE_SIZE = 10
    EXPIRY_IN_MINUTES = 120

    class Channel
      constructor: (@channelName) ->
        @highlights = []
        @_someReadyDeferred = $q.defer()
        @_allReadyDeferred = $q.defer()
        @someReady = @_someReadyDeferred.promise
        @allReady = @_allReadyDeferred.promise

      update: ->
        cachedHighlights = @_fetchHighlightsFromCache()
        console.log(cachedHighlights)
        batchSize = if cachedHighlights? then UPDATE_SIZE else BATCH_SIZE
        @_fetchHighlights(batchSize, 0, cachedHighlights || [])


      _fetchHighlights: (batchSize, offset, tailHighlights) ->
        done = false
        new TwitchApi().fetchHighlights(@channelName, batchSize, offset).then (response) =>
          videos = response.videos
          _.each videos, (video) =>
            highlight = new Highlight(video)
            if highlight.equals(tailHighlights[0])
              @highlights = @highlights.concat(tailHighlights)
              done = true
              $timeout => @_doneFetching()
              false
            else
              @highlights.push(highlight)

          @_someReadyDeferred.resolve()

          if !done
            if videos.length == batchSize
              @_fetchHighlights(BATCH_SIZE, offset + batchSize, tailHighlights)
            else
              $timeout => @_doneFetching()

      _doneFetching: ->
        @_storeHighlightsToCache(@highlights)
        @_allReadyDeferred.resolve()

      _fetchHighlightsFromCache: ->
        cachedHighlights = LsCache.get(@_cacheKey())
        if cachedHighlights?
          Highlight.wrapArray(cachedHighlights)

      _storeHighlightsToCache: (highlights) ->
        console.log("store")
        LsCache.set(@_cacheKey(), highlights, EXPIRY_IN_MINUTES)

      _cacheKey: ->
        "channel.#{@channelName}.highlights"