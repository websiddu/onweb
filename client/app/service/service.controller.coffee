'use strict'

angular.module 'sociallinkApp'
.controller 'ServiceCtrl', ($scope, $http) ->

  $http.get '/api/services'
  .success (services) ->
    $scope.services = services


  # $scope.addUser = function() {
  #   $scope.inserted = {
  #     id: $scope.users.length+1,
  #     name: '',
  #     status: null,
  #     group: null
  #   };
  #   $scope.users.push($scope.inserted);
  # };

  $scope.saveService = (data, id) ->
    $http.put("/api/services/#{id}", data)
      .success (dt, status) ->
        # $scope.services[id]._id = dt._id

  $scope.addNewService = (e) ->
    $scope.newSer =
      name: null
      url: null
      icon: null
      status: null
    $http.post('/api/services', $scope.newSer)
      .success (dt, status) ->
        $scope.newSer._id = dt._id
        $scope.services.push($scope.newSer)

  _resetForm = ->
    $scope.serviceName = null
    $scope.serviceURL = null
    $scope.serviceIcon = null
    $scope.scopeStatus = false

  $scope.removeService = (index, service) ->
    $http
      method: 'DELETE'
      url: "/api/services/#{service}"
    .success (data, status) ->
      $scope.services.splice(index, 1)
