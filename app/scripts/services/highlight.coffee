angular.module 'blimp'
  .factory 'Highlight', ->
    formatLength = (length) ->
      hours = ~~(length / 3600)
      minutes = ((length % 3600) / 60)
      if minutes >= 1
        minutes = Math.round(minutes)
      seconds = length % 60
      [
        if hours > 0 then "#{hours} h",
        if minutes >= 1 then "#{minutes} min",
        if minutes < 1 then "#{seconds} sec"
      ].join(' ')

    class Highlight
      constructor: (data) ->
        _.extend(@, data)
        @_searchText = [@title, @description, @game].join(' ').toLowerCase()
        @length_in_minutes = formatLength(@length)

      @wrapArray: (array) ->
        _.map array, (data) ->
          new Highlight(data)

      equals: (otherHighlight) ->
        otherHighlight && @_id == otherHighlight._id

      matches: (query) ->
        _.all query.split(' '), (token) =>
          _.includes @_searchText, token
