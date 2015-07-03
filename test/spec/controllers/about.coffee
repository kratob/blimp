'use strict'

describe 'Controller: AboutCtrl', ->

  # load the controller's module
  beforeEach module 'brexSearchApp'

  AboutCtrl = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    AboutCtrl = $controller 'AboutCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(AboutCtrl.awesomeThings.length).toBe 3
