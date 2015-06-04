'use strict'

angular.module 'pos', [
    'ngRoute'
    'ngResource'
    'ui.bootstrap'
    # 'ngAnimate'
    # 'ngCookies'
    # 'ngSanitize'
    # 'ngTouch'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/employee',
        templateUrl: 'views/employee.html'
        controller: 'EmployeeCtrl'
      .when '/product',
        templateUrl: 'views/product.html'
        controller: 'ProductCtrl'
      .otherwise
        redirectTo: '/'