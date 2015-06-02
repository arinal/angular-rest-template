'use strict'

angular.module('pos').filter 'pages', ->
	(input, currentPage, totalPages, range) ->
		currentPage = parseInt currentPage
		totalPages = parseInt totalPages
		range = parseInt range

		minPage =
			if currentPage - range < 0
				0 
			else if currentPage - range > (totalPages - (range * 2))
				totalPages - (range * 2)
			else currentPage - range
		maxPage = 
			if currentPage + range > totalPages
				totalPages
			else if currentPage + range < range * 2
				range * 2
			else currentPage + range;

		input.push i for i in [minPage...maxPage]
		input