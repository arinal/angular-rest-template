'use strict'

describe 'Filter: pages', ->

  # load the filter's module
  beforeEach module 'restClientTemplateApp'

  # initialize a new instance of the filter before each test
  pages = {}
  beforeEach inject ($filter) ->
    pages = $filter 'pages'

  it 'should return the input prefixed with "pages filter:"', ->
    text = 'angularjs'
    expect(pages text).toBe ('pages filter: ' + text)
