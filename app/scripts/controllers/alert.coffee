'use strict'

angular.module('pos').controller 'AlertCtrl', ($scope, messageBus) ->

	$scope.alerts = []

	$scope.dismiss = (index) -> $scope.alerts.splice(index, 1)

	messageBus.on 'entity-saved', $scope, (_, args) ->
		$scope.alerts.push
			level: 'success'
			message: "#{args.type} #{args.data.code} has been saved."

	messageBus.on 'entity-deleted', $scope, (_, args) ->
		$scope.alerts.push
			level: 'success'
			message: "#{args.type} #{args.data.code} has been deleted."

	messageBus.on 'entity-deletion-failed', $scope, (_, args) ->
		$scope.alerts.push
			level: 'danger'
			message: "#{args.type} #{args.data.code} deletion has been failed."
