'use strict'

angular.module('pos').controller 'EmployeeCtrl', ($rootScope, $scope, $resource) ->
	window.extendScope 'employee', $rootScope, $scope, $resource, 'EmployeeViewModel'
	$scope.refresh()
	
class window.EmployeeViewModel extends window.EntityViewModel
	constructor: (@originalEntity) -> super @originalEntity
	
	getEntity: ->
		id: @id
		code: @code
		name: @name
		gender: @gender
		birthDate: @dateToArray @birthDate

	revert: -> @transform @originalEntity

	transform: (entity) ->
		{@id, @code, @name, @gender, @birthDate} = entity
		@birthDate = new Date @birthDate