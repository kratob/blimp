describe 'Service: Channel', ->

  # instantiate service
  Channel = {}
  Highlight = {}
  $httpBackend = {}
  $timeout = {}

  mockLsCache =
    get: ->
    set: ->


  beforeEach ->
    module 'blimp'

    module ($provide) ->
      $provide.value('LsCache', mockLsCache)
      return

    inject (_Channel_, _$httpBackend_, _$timeout_, _Highlight_) ->
      Channel = _Channel_
      Highlight = _Highlight_
      $httpBackend = _$httpBackend_
      $timeout = _$timeout_

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()


  describe '#update', ->

    channel = {}
    videos = _.map [1..120], (i) -> { _id: "video#{i}" }

    highlightsForVideos = (videos) ->
      asymmetricMatch: (actual) ->
        _.isEqual _.pluck(actual, '_id'), _.pluck(videos, '_id')

    beforeEach ->
      channel = new Channel('channelName')

    it 'fetches all highlights in batches of 100 for the given channel', ->
      $httpBackend.expect('JSONP', 'https://api.twitch.tv/kraken/channels/channelName/videos?callback=JSON_CALLBACK&limit=100&offset=0')
        .respond
          videos: videos[..99]

      $httpBackend.expect('JSONP', 'https://api.twitch.tv/kraken/channels/channelName/videos?callback=JSON_CALLBACK&limit=100&offset=100')
        .respond
          videos: videos[100..]

      channel.update()
      $httpBackend.flush()

      expect(_.pluck channel.highlights, '_id').toEqual _.pluck(videos, '_id')


    it 'caches results', ->
      $httpBackend.expect('JSONP', 'https://api.twitch.tv/kraken/channels/channelName/videos?callback=JSON_CALLBACK&limit=100&offset=0')
        .respond
          videos: videos[..2]

      spyOn mockLsCache, 'set'

      channel.update()
      $httpBackend.flush()
      $timeout.flush()

      expect(mockLsCache.set).toHaveBeenCalledWith "channel.channelName.highlights", highlightsForVideos(videos[..2]), 120


    it 'merges new videos with cached results', ->
      $httpBackend.expect('JSONP', 'https://api.twitch.tv/kraken/channels/channelName/videos?callback=JSON_CALLBACK&limit=10&offset=0')
        .respond
          videos: videos[..9]

      spyOn mockLsCache, 'get'
        .and.returnValue videos[4..]

      channel.update()
      $httpBackend.flush()
      $timeout.flush()

      expect(_.pluck channel.highlights, '_id').toEqual _.pluck(videos, '_id')


    it 'resolves the promise', ->
      $httpBackend.expect('JSONP', 'https://api.twitch.tv/kraken/channels/channelName/videos?callback=JSON_CALLBACK&limit=100&offset=0')
        .respond
          videos: videos[..5]

      resolved = false
      channel.update().then -> resolved = true
      $httpBackend.flush()
      $timeout.flush()

      expect(resolved).toBe true


    it 'rejects the promise with an error message if the api returns an error', ->
      $httpBackend.expect('JSONP', 'https://api.twitch.tv/kraken/channels/channelName/videos?callback=JSON_CALLBACK&limit=100&offset=0')
        .respond
          error: 422
          message: 'error message'

      rejectMessage = ''
      channel.update().then ->
          return
        , (message) ->
          rejectMessage = message
      $httpBackend.flush()
      $timeout.flush()

      expect(rejectMessage).toEqual 'error message'
