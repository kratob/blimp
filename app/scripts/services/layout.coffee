angular.module 'brexSearchApp'
  .factory 'Layout', ->
    DEFAULT_TITLE = 'Twitch Highlight Search'
    class Layout
      @title: DEFAULT_TITLE
