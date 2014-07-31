boutiqueApp = angular.module('boutiqueApp', [
  'ui.bootstrap',
  'ngRoute',
  'boutiqueControllers'
])

boutiqueApp.config(['$routeProvider',
  ($routeProvider) ->
    $routeProvider.
      when('/clothing', {
          templateUrl: '/templates/clothing.html',
          controller: 'BoutiqueCtrl'
        }).
      otherwise({
          redirectTo: '/clothing'
        });
])