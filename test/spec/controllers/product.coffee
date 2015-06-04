'use strict'

describe 'Controller: ProductCtrl', ->

  # load the controller's module
  beforeEach module 'restClientTemplateApp'

  ProductCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ProductCtrl = $controller 'ProductCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
