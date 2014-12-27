'use strict'

angular.module 'sociallinkApp'
.config ($routeProvider) ->
  $routeProvider.when '/profile',
    templateUrl: 'app/profile/profile.html'
    controller: 'ProfileCtrl'
