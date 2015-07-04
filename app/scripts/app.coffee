angular
  .module 'blimp', [
    'ngAnimate',
    'ngRoute',
    'material.components.button',
    'material.components.content',
    'material.components.icon',
    'material.components.input',
    'material.components.progressCircular',
    'material.components.toolbar',
    'material.components.whiteframe',
    'infinite-scroll',
  ]
  .config ($mdThemingProvider) ->
    $mdThemingProvider.theme 'default'
      .primaryPalette('brown')
      .accentPalette('amber')
  .constant('CLIENT_ID', 'a8qaz7546qrb99s5zld1jarktkz8byx')
