angular.module 'blimp'
  .factory 'Layout', ($rootScope, $document) ->
    DEFAULT_TITLE = 'Blimp (Twitch Highlight Search)'

    Layout =
      setTitle: (title) ->
        Layout.title = $document[0].title = title

    Layout.setTitle DEFAULT_TITLE

    $rootScope.$on '$routeChangeSuccess', ->
      Layout.setTitle DEFAULT_TITLE

    Layout
