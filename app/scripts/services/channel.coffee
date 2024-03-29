angular.module 'blimp'
  .factory 'Channel', (LsCache, TwitchApi, Highlight, $q, $timeout) ->
    BATCH_SIZE = 100
    MAX_OFFSET = 700
    UPDATE_SIZE = 10
    EXPIRY_IN_MINUTES = 2 * 60  # 2 hours

    class Channel
      constructor: (@channelName) ->
        @highlights = []
        @_allReadyDeferred = $q.defer()
        @_someReadyDeferred = $q.defer()
        @allReady = @_allReadyDeferred.promise
        @someReady = @_someReadyDeferred.promise

      update: ->
        cachedHighlights = @_fetchHighlightsFromCache()
        batchSize = if cachedHighlights? then UPDATE_SIZE else BATCH_SIZE
        @_fetchHighlights(batchSize, 0, cachedHighlights || [])
        @allReady


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
            if videos.length >= batchSize && offset + batchSize <= MAX_OFFSET
              @_fetchHighlights(BATCH_SIZE, offset + batchSize, tailHighlights)
            else
              $timeout => @_doneFetching()
        , (errorMessage) =>
          @highlights = []
          @error = errorMessage
          @_someReadyDeferred.reject()
          @_allReadyDeferred.reject(@error)

      _doneFetching: ->
        @_storeHighlightsToCache(@highlights)
        @_someReadyDeferred.resolve()
        @_allReadyDeferred.resolve()

      _fetchHighlightsFromCache: ->
        cachedHighlights = LsCache.get(@_cacheKey())
        if cachedHighlights?
          Highlight.wrapArray(cachedHighlights)

      _storeHighlightsToCache: (highlights) ->
        LsCache.set(@_cacheKey(), highlights, EXPIRY_IN_MINUTES)

      _cacheKey: ->
        "channel.#{@channelName}.highlights"
