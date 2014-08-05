boutiqueApp = angular.module('boutiqueApp', [
  'ui.bootstrap',
  'ngRoute',
  'boutiqueControllers'
])

boutiqueApp.config(['$routeProvider',
  ($routeProvider) ->
    $routeProvider.
      when('/', {
          templateUrl: '/templates/main.html',
          controller: 'MainCtrl'
        }).
      when('/logout', {
          templateUrl: '/templates/logout.html',
          controller: 'LogoutCtrl'
        }).
      when('/new_clothing', {
          templateUrl: '/templates/new_clothing.html',
          controller: 'NewClothingCtrl'
        }).
      when('/info_clothing', {
          templateUrl: '/templates/info_clothing.html',
          controller: 'NewClothingCtrl'
        }).
      when('/testclothing', {
          templateUrl: '/templates/clothing.html',
          controller: 'BoutiqueCtrl'
        })
])