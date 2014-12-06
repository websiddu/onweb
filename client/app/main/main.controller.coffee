'use strict'

angular.module 'sociallinkApp'
.controller 'MainCtrl', ($scope, $http, socket) ->
  $scope.awesomeLinks = []

  $http.get('/api/links').success (awesomeLinks) ->
    $scope.awesomeLinks = awesomeLinks
    socket.syncUpdates 'link', $scope.awesomeLinks

  $scope.addThing = ->
    return if $scope.newThing is ''
    $http.post '/api/links',
      name: $scope.newThing
      link: "String"
      icon: "String"
      handle: "String"

    $scope.newThing = ''

  $scope.deleteThing = (link) ->
    $http.delete '/api/links/' + link._id

  $scope.$on '$destroy', ->
    socket.unsyncUpdates 'link'
