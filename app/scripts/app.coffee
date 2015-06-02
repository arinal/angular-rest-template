'use strict'

angular.module 'pos', [
    'ngAnimate'
    'ngCookies'
    'ngResource'
    'ngRoute'
    'ngSanitize'
    'ngTouch'
    'ngResource'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/employee',
        templateUrl: 'views/employee.html'
        controller: 'EmployeeCtrl'
      .otherwise
        redirectTo: '/'

