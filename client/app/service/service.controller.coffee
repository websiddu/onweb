'use strict'

angular.module 'sociallinkApp'
.controller 'ServiceCtrl', ($scope, $http) ->

  $http.get '/api/services'
  .success (services) ->
    $scope.services = services

  $scope.addNewService = (e) ->
    newSer =
      name: $scope.serviceName
      url: $scope.serviceURL
      icon: $scope.serviceIcon
      status: $scope.scopeStatus

    $http.post('/api/services', newSer)
      .success (data, status) ->
        newSer._id = data._id
        $scope.services.push(newSer)
        _resetForm()

  _resetForm = ->
    $scope.serviceName = null
    $scope.serviceURL = null
    $scope.serviceIcon = null
    $scope.scopeStatus = false

  $scope.removeService = (service, index) ->
    $http
      method: 'DELETE'
      url: "/api/services/#{service}"
    .success (data, status) ->
      $scope.services.splice(index, 1)
