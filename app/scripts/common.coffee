'use strict'

class window.viewModel
	constructor: (@name, @viewModelClass, @bus, scope, resource) ->
		@restResource = resource "http://localhost:8080/#{@name}/:id"
		@basePath = @name
		@page = number: 0, size: 3
		@entityModels = []
		
		@bus.on 'search', scope, (_, key) => @refresh key


	getSelectedEntity: -> @selected.getEntity()
	addEntity: (entity) -> @entityModels.push new window[@viewModelClass] entity
	revertEntityModel: -> @selected.revert()

	selectModel: (model) ->
		@selected.status = '' if @selected
		@selected = model
		@selected.status = 'info'

	refresh: (key = '') ->
		@restResource.get {search: key, page: @page.number, size: @page.size}, (data) =>
			@entityModels = []
			list = if data._embedded then data._embedded["#{@name}List"] else []
			@addEntity e for e in list
			@page = data.page

	add: ->
		@restResource.get {id: 0}, (data) =>
			@selected = new window[@viewModelClass] data

	save: ->
		@restResource.save @getSelectedEntity(), =>
			@bus.emit 'entity-saved',
				data: @selected
				type: @name
			@refresh()

	delete: ->
		@restResource.delete {id: @selected.id}
			, =>	
				@bus.emit 'entity-deleted',
					data: @selected
					type: @name
				@refresh()
				@selectModel {}
			, =>
				@bus.emit 'entity-deletion-failed',
					data: @selected
					type: @name

	gotoFirstPage: ->
		@page.number = 0
		@refresh()

	gotoLastPage: ->
		@page.number = @page.totalPages - 1
		@refresh()

	gotoPreviousPage: ->
		@page.number--
		@refresh()

	gotoNextPage: ->
		@page.number++
		@refresh()

	gotoPage: (n) ->
		@page.number = n
		@refresh()


class window.entityViewModel
	constructor: (@raw) -> @transform @raw		
	getEntity: -> id: @id
	revert: -> @transform @raw
	transform: (obj) -> {@id, @code} = obj

	dateToArray: (date) -> [date.getFullYear(), date.getMonth() + 1, date.getDate()]
	timeToArray: (date) -> [date.getFullYear(), date.getMonth() + 1, date.getDate()
		date.getHours(), date.getMinutes(), date.getSeconds(), date.getMilliseconds()]

	popDate: (event, name) ->
		event.preventDefault()
		event.stopPropagation()
		this[name] = true
