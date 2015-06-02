'use strict'

angular.module('pos').controller 'EmployeeCtrl', ($rootScope, $scope, $resource) ->
	window.extendScope 'employee', $rootScope, $scope, $resource
	$scope.refresh()