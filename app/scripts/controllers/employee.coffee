'use strict'

angular.module('pos').controller 'employeeCtrl', ($scope, $resource, messageBus) ->
	$scope.vm = new window.viewModel 'employee', 'employeeViewModel', messageBus, $scope, $resource
	$scope.vm.refresh()
	
class window.employeeViewModel extends window.entityViewModel
	constructor: (@raw) -> super @raw
	
	getEntity: ->
		id: @id
		code: @code
		name: @name
		gender: @gender
		birthDate: @dateToArray @birthDate

	transform: (obj) ->
		{@id, @code, @name, @gender, @birthDate} = obj
		@birthDate = new Date @birthDate