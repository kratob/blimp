twitchHttpMock = require('./mocks/twitch_http_mock')

describe 'channel', ->

  beforeEach ->
    browser.addMockModule('twitchHttpMock', twitchHttpMock.twitchHttpMock)
    browser.get('/#/bananasaurus_rex')

  it 'has a title',  ->
    expect(element(findBy.css('md-toolbar')).getText()).toContain 'bananasaurus_rex'

  it 'shows highlights', ->
    firstHighlight = element(findBy.repeater('highlight in channel.highlights').row(0)).getText()

    expect(firstHighlight).toContain('[EPILEPSY WARNING] Rex plays I Wanna Be the Permanence 2')
    expect(firstHighlight).toContain('Jun 23, 2015')
    expect(firstHighlight).toContain('Rex flies into and finishes his playthrough')
    expect(firstHighlight).toContain('4 h 41 min')
    expect(firstHighlight).toContain('193')

    secondHighlight = element(findBy.repeater('highlight in channel.highlights').row(2)).getText()

    expect(secondHighlight).toContain('Rexernlion')

  it 'allows filtering', ->
    element(findBy.model('channel.query')).sendKeys('lion')

    rows = element.all(findBy.repeater('highlight in channel.highlights'))

    expect(rows.then (r) -> r.length).toEqual 1
    expect(rows.first().getText()).toContain 'Rexernlion'

    element(findBy.model('channel.query')).clear()
    expect(rows.then (r) -> r.length).toEqual 3
