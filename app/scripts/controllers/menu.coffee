angular.module('pos').controller 'menuCtrl', ($scope, messageBus) ->
	$scope.search = -> messageBus.emit 'search', $scope.searchKey