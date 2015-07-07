'use strict'

class window.viewModel
	constructor: (@name, @entityViewModelClass, @bus, scope, resource) ->
		@restResource = resource "http://localhost:8080/#{@name}/:id"
		@basePath = @name
		@page = number: 0, size: 3
		@entityModels = []
		@bus.on 'search', scope, (_, key) => @refresh key

	getSelectedEntity: -> @selected.getEntity()
	addEntity: (entity) -> @entityModels.push new window[@entityViewModelClass] entity
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

	refreshSelected: ->
		@restResource.get {id: selected.id}, (data) =>
			@selectModel new window[@entityViewModelClass] data

	add: ->
		@restResource.get {id: 0}, (data) =>
			@selectModel new window[@entityViewModelClass] data

	save: ->
		@restResource.save @getSelectedEntity(), =>
			@bus.emit 'entity-saved',
				data: @selected
				type: @name
			@refresh()
			@refreshSelected()

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

	gotoFirstPage: -> @gotoPage 0
	gotoLastPage: -> @gotoPage @page.totalPages - 1
	gotoPreviousPage: -> @gotoPage --@page.number
	gotoNextPage: -> @gotoPage ++@page.number
	gotoPage: (n) ->
		@page.number = n
		@refresh()

	initSearchBy: (resource, name...) ->
		@initSearch resource, n for n in name

	initSearch: (resource, n) ->
		rsc = resource "http://localhost:8080/#{n}"
		@["search#{n}"] = (key) ->
			rsc.get {search: key, page: 0, size: 3}, (data) =>
				@["#{n}Result"] = if data._embedded then data._embedded["#{n}List"] else []

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
