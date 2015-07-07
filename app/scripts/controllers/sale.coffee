'use strict'

angular.module('pos').controller 'saleCtrl', ($scope, $resource, $http, messageBus) ->
	$scope.vm = new window.saleViewModel 'sale', 'saleEntityViewModel', messageBus, $scope, $resource
	$scope.vm.refresh()

class window.saleViewModel extends window.viewModel
	constructor: (name, clazz, bus, scope, resource) ->
		super name, clazz, bus, scope, resource
		@initSearchBy resource, 'employee', 'product'

class window.saleEntityViewModel extends window.entityViewModel
	constructor: (@raw) -> super @raw
	
	getEntity: ->
		id: @id
		code: @code
		time: @timeToArray @time
		cashier: @cashier
		lineItems: @lineItems

	timeString: -> @time.toLocaleString()

	transform: (obj) ->
		{@id, @code, @time, @total, @cashier} = obj
		@lineItems = []
		@time = new Date @time[0], @time[1], @time[2], @time[3], @time[4], @time[5]
		@addLineItem sli for sli in obj.lineItems

	addLineItem: (sli) -> 
		@lineItems.push new window.saleLineItemVM(sli)

	addLineItemAt: (index) ->
		@lineItems.splice index + 1, 0, new window.saleLineItemVM

	removeLineItemAt: (index) ->
		@lineItems.splice index, 1

class window.saleLineItemVM extends window.entityViewModel
	constructor: (@raw) -> super @raw
	
	transform: (obj) ->
		if obj is undefined
			[@product, @quantity, @unitPrice, @subtotal] = [undefined, 0, 0, 0]
		else
			{@product, @quantity, @unitPrice, @subtotal} = obj