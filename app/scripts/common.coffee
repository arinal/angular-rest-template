'use strict'

window.extendScope = (name, rootScope, scope, resource, viewModelClass) ->
	restResource = resource "http://localhost:8080/#{name}/:id"
	
	scope.basePath = name
	scope.page = number: 0, size: 3
	scope.entityModels = []

	getSelectedEntity = -> scope.selected.getEntity()

	addEntity = (entity) -> 
		scope.entityModels.push new window[viewModelClass] entity

	scope.selectModel = (model) -> scope.selected = model

	scope.revertEntityModel = -> scope.selected.revert()

	scope.refresh = ->
		restResource.get {page: scope.page.number, size: scope.page.size}, (data) ->
			scope.entityModels = []
			list = if data._embedded then data._embedded["#{name}List"] else []
			addEntity e for e in list
			# [scope.selected] = scope.entityModels # select first
			scope.page = data.page

	scope.add = ->
		restResource.get {id: 0}, (data) ->
			scope.selected = new window[viewModelClass] data

	scope.save = ->
		restResource.save getSelectedEntity(), ->
			rootScope.$broadcast 'entity-saved',
				data: scope.selected
				type: name
			scope.refresh()
			for m in scope.entityModels
				scope.selectModel m if m.id == scope.selected.id
			

	scope.delete = ->
		restResource.delete {id: scope.selected.id}
			, ->	
				rootScope.$broadcast 'entity-deleted',
					data: scope.selected
					type: name
				scope.refresh()
				scope.selectModel {}
			, ->
				rootScope.$broadcast 'entity-deletion-failed',
					data: scope.selected
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


class window.EntityViewModel
	constructor: (@originalEntity) -> @transform @originalEntity
	getEntity: -> id: @id
	revert: -> {@id, @code} = @originalEntity
	
	dateToArray: (date) -> [date.getFullYear(), date.getMonth() + 1, date.getDate()]

	transform: (entity) ->
		{@id, @code} = entity

	popDate: (event, name) ->
		event.preventDefault()
		event.stopPropagation()
		this[name] = true