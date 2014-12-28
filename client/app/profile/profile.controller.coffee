'use strict'

angular.module 'sociallinkApp'
.controller 'ProfileCtrl', ($scope, Auth) ->
  user = Auth.getCurrentUser()
  provider = user.provider
  $scope.profilePic = user[provider].picture

