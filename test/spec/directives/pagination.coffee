'use strict'

describe 'Directive: pagination', ->

  # load the directive's module
  beforeEach module 'restClientTemplateApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<pagination></pagination>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the pagination directive'
