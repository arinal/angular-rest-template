'use strict'

window.extendScope = (name, rootScope, scope, resource) ->
	restResource = resource "http://localhost:8080/#{name}/:id"
	scope.basePath = name

	scope.refresh = ->
		restResource.get {page: scope.page.number, size: scope.page.size}, (data) ->
			scope.entities = data._embedded["#{name}List"]
			scope.page = data.page
			scope.entity = scope.entities[0]

	scope.add = ->
		restResource.get {id: 0}, (data) ->
			scope.entity = data

	scope.save = ->
		restResource.save scope.entity, ->
			rootScope.$broadcast 'entity-saved',
				data: scope.entity
				type: name
			scope.refresh()

	scope.delete = ->
		restResource.delete {id: scope.entity.id}
			, ->	
				rootScope.$broadcast 'entity-deleted',
					data: scope.entity
					type: name
				scope.refresh()
			, ->
				rootScope.$broadcast 'entity-deletion-failed',
					data: scope.entity
					type: name

	scope.gotoFirstPage = ->
		scope.page.number = 0
		scope.refresh()

	scope.gotoLastPage = ->
		scope.page.number = scope.page.totalPages - 1
		scope.refresh()

	scope.gotoPreviousPage = ->
		scope.page.number--
		scope.refresh()

	scope.gotoNextPage = ->
		scope.page.number++
		scope.refresh()

	scope.gotoPage = (n) ->
		scope.page.number = n
		scope.refresh()

	scope.page = number: 0, size: 3