describe 'Service: Highlight', ->

  # load the service's module
  beforeEach module 'blimp'

  # instantiate service
  Highlight = {}
  beforeEach inject (_Highlight_) ->
    Highlight = _Highlight_

  it 'wraps data', ->
    highlight = new Highlight
      title: 'A title'
      length: 100

    expect(highlight.title).toEqual 'A title'
    expect(highlight.length).toEqual 100

  describe '#matches', ->
    highlight = {}

    beforeEach ->
      highlight = new Highlight
        title: 'A TITLE'
        description: 'A description'
        game: 'A game'

    it 'returns true if the search text is included in the title', ->
      expect(highlight.matches('title')).toBe true

    it 'returns true if the search text is included in the description', ->
      expect(highlight.matches('description')).toBe true

    it 'returns true if the search text is included in the game name', ->
      expect(highlight.matches('game')).toBe true

    it 'returns true if all search words are present', ->
      expect(highlight.matches('title description')).toBe true

    it 'returns false if one search word is not present', ->
      expect(highlight.matches('title something')).toBe false

    it 'returns true for partial matches', ->
      expect(highlight.matches('escriptio')).toBe true

  describe 'human_length', ->

    it 'returns hours and rounds to minutes', ->
      expect(new Highlight(length: 2 * 3600 + 10 * 60 + 55).human_length).toEqual '2 h 11 min '

    it 'does not show irrelevant fields', ->
      expect(new Highlight(length: 2 * 3600).human_length).toEqual '2 h  '
      expect(new Highlight(length: 20 * 60).human_length).toEqual ' 20 min '

    it 'shows seconds if less than a minute', ->
      expect(new Highlight(length: 59).human_length).toEqual '  59 sec'
