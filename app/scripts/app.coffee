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
        controller: 'mainCtrl'
      .when '/sale',
        templateUrl: 'views/sale.html'
        controller: 'saleCtrl'
      .when '/employee',
        templateUrl: 'views/employee.html'
        controller: 'employeeCtrl'
      .when '/product',
        templateUrl: 'views/product.html'
        controller: 'productCtrl'
      .otherwise
        redirectTo: '/'