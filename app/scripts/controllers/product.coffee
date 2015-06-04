'use strict'

angular.module('pos').controller 'ProductCtrl', ($rootScope, $scope, $resource) ->
	window.extendScope 'product', $rootScope, $scope, $resource
	$scope.refresh()