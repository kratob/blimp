angular.module 'blimp'
  .controller 'ChannelCtrl', ($routeParams, Channel, Layout) ->
    @channelName = $routeParams.channelName
    @results = undefined
    @loading = true
    @query = ''
    allHighlights = undefined
    matchingHighlights = undefined
    channel = new Channel(@channelName)


    Layout.setTitle @channelName
    channel.update().then =>
      allHighlights = channel.highlights
      @filter()
      @loading = false
    , (error) =>
      @error = error
      @loading = false

    channel.someReady.then =>
      allHighlights = channel.highlights
      @filter()


    @filter = ->
      query = @query.toLowerCase()
      if query == ''
        matchingHighlights = allHighlights
      else
        matchingHighlights = _.filter allHighlights, (highlight) ->
          highlight.matches(query)
      @highlights = []
      @addBatch()

    @addBatch = ->
      return unless matchingHighlights?
      newSize = @highlights.length + 20
      @highlights = matchingHighlights[0..newSize]

    return
