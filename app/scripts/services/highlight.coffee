angular.module 'brexSearchApp'
  .factory 'Highlight', ->
    class Highlight
      constructor: (data) ->
        _.extend(@, data)
        @_searchText = (@description || '').toLowerCase()

      @wrapArray: (array) ->
        _.map array, (data) ->
          new Highlight(data)

      equals: (otherHighlight) ->
        otherHighlight && @_id == otherHighlight._id

      matches: (query) ->
        _.includes @_searchText, query
