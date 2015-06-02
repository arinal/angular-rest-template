'use strict'

describe 'Controller: EmployeeCtrl', ->

  # load the controller's module
  beforeEach module 'restClientTemplateApp'

  EmployeeCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    EmployeeCtrl = $controller 'EmployeeCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
