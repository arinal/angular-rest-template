'use strict'

angular.module('pos').controller 'productCtrl', ($scope, $resource, messageBus) ->
	$scope.vm = new window.viewModel 'product', 'productViewModel', messageBus, $scope, $resource
	$scope.vm.refresh()
	
class window.productViewModel extends window.entityViewModel
	constructor: (@raw) -> super @raw
	
	getEntity: ->
		id: @id
		code: @code
		name: @name
		unitPrice: @unitPrice

	transform: (obj) -> {@id, @code, @name, @unitPrice} = obj