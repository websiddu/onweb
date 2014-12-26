'use strict'

angular.module 'sociallinkApp'
.config ($routeProvider) ->
  $routeProvider.when '/service',
    templateUrl: 'app/service/service.html'
    controller: 'ServiceCtrl'
    authenticate: true
