angular.module 'blimp'
  .factory 'Layout', ($rootScope) ->
    DEFAULT_TITLE = 'Blimp (Twitch Highlight Search)'
    Layout =
      title: DEFAULT_TITLE

    $rootScope.$on '$routeChangeSuccess', ->
      Layout.title = DEFAULT_TITLE

    Layout
