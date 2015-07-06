'use strict'

angular.module('pos').controller 'saleCtrl', ($scope, $resource, messageBus) ->
	$scope.vm = new window.viewModel 'sale', 'saleViewModel', messageBus, $scope, $resource
	$scope.vm.refresh()
	
class window.saleViewModel extends window.entityViewModel
	constructor: (@raw) -> super @raw
	
	getEntity: ->
		id: @id
		code: @code
		time: @timeToArray @time
		lineItems: @lineItems

	timeString: -> @time.toLocaleString()

	transform: (obj) ->
		{@id, @code, @time} = obj
		@lineItems = []
		@time = new Date @time[0], @time[1], @time[2], @time[3], @time[4], @time[5]
		@addLineItem sli for sli in obj.lineItems

	addLineItem: (sli) ->
		@lineItems.push new window.saleLineItemVM(sli)

class window.saleLineItemVM extends window.entityViewModel
	constructor: (@raw) -> super @raw
	
	transform: (obj) ->
		@product = obj.product
		@quantity = obj.quantity
		@unitPrice = obj.unitPrice
		@subtotal = obj.subtotal
