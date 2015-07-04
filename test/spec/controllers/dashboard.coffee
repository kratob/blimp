'use strict'

describe 'Controller: DashboardCtrl', ->

  # load the controller's module
  beforeEach module 'blimp'

  DashboardCtrl = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    DashboardCtrl = $controller 'DashboardCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(DashboardCtrl.awesomeThings.length).toBe 3
