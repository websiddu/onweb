'use strict'

angular.module 'sociallinkApp'
.controller 'ProfileCtrl', ($scope, Auth, $http) ->
  user = Auth.getCurrentUser()
  provider = user.provider
  $scope.profilePic = user[provider].picture
  $scope.userLinks = []

  $scope.init = ->
    console.log user
    _loadUserLinks()

  _loadUserLinks = ->
    $http
      url: '/api/users/links'
      method: 'GET'
    .success (data, status) ->
      $scope.userLinks = data

  $scope.init()

