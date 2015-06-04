'use strict'

angular.module('pos').controller 'AlertCtrl', ($scope) ->

	$scope.dismiss = (index) ->
		$scope.alerts.splice(index, 1)

	$scope.$on 'entity-saved', (_, args) ->
		$scope.alerts.push
			level: 'success'
			message: "#{args.type} #{args.data.code} has been saved."

	$scope.$on 'entity-deleted', (_, args) ->
		$scope.alerts.push
			level: 'success'
			message: "#{args.type} #{args.data.code} has been deleted."

	$scope.$on 'entity-deletion-failed', (_, args) ->
		$scope.alerts.push
			level: 'danger'
			message: "#{args.type} #{args.data.code} deletion has been failed."

	$scope.alerts = []