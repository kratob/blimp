'use strict'

describe 'Controller: LayoutCtrl', ->

  # load the controller's module
  beforeEach module 'blimp'

  LayoutCtrl = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    LayoutCtrl = $controller 'LayoutCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(LayoutCtrl.awesomeThings.length).toBe 3
