'use strict'

describe 'Service: layout', ->

  # load the service's module
  beforeEach module 'brexSearchApp'

  # instantiate service
  layout = {}
  beforeEach inject (_layout_) ->
    layout = _layout_

  it 'should do something', ->
    expect(!!layout).toBe true
