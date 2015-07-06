'use strict'

angular.module('pos').factory 'messageBus', ($rootScope) ->
    emit: (message, data) -> $rootScope.$emit message, data
    on: (message, scope, func) ->
    	unbind = $rootScope.$on message, func
    	scope.$on '$destroy', unbind