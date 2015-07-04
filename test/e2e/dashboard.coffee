twitchHttpMock = require('./mocks/twitch_http_mock')

describe 'dashboard', ->

  beforeEach ->
    browser.addMockModule('twitchHttpMock', twitchHttpMock.twitchHttpMock)
    browser.get('/')

  it 'has a title',  ->
    expect(element(findBy.css('md-toolbar')).getText()).toContain 'Twitch Highlight Search'

  it 'allow to switch to a channel', ->
    element(findBy.model('channelName')).sendKeys('bananasaurus_rex')
    element(findBy.buttonText('Go!')).click()
    expect(browser.getCurrentUrl()).toMatch /\#\/bananasaurus_rex$/
