'use strict'

angular.module 'sociallinkApp'
.controller 'MainCtrl', ($scope, $http, socket) ->
  $scope.awesomeLinks = []

  $scope.userservices = []

  # $http.get('/api/links').success (awesomeLinks) ->
  #   $scope.awesomeLinks = awesomeLinks
  #   socket.syncUpdates 'link', $scope.awesomeLinks

  $scope.removeLink = (service) ->
    $http.delete('/api/links/' + service._id)
      .success (data, status) ->
        service.userhas = false
        service.updateurl = undefined
        service.url = service.baseurl

  $scope.init = ->
    $http.get '/api/services'
      .success (services) ->
        $scope.userservices = services
        $http.get '/api/users/links'
          .success (links) ->
            $scope.userlinks = links
            _combineLinks()

  _combineLinks = ->
    slen = $scope.userservices.length
    i = 0;
    while i < slen
      findedlinks =  _.find($scope.userlinks, (lnk) ->
        return lnk.name is $scope.userservices[i].name
        )
      baseUrl = $scope.userservices[i].url
      if (findedlinks)
        $scope.userservices[i] = findedlinks
        $scope.userservices[i].userhas = true
        $scope.userservices[i].updateurl = "/api/links/u/#{findedlinks._id}"
      else
        $scope.userservices[i].userhas = false
        $scope.userservices[i].updateurl = undefined

      $scope.userservices[i].baseurl = baseUrl
      $scope.userservices[i].dropdown = false
      i++

  $scope.updateLink = (service, data) ->
    console.log data

    newService =
      name: service.name
      url: data
      icon: service.icon
      _id: service._id

    console.log newService

    $http
      method: 'PUT'
      url: '/api/links/u/'
      data:
        data: newService
    .success (data, status) ->
      service.userhas = true
      service.updateurl = "/api/links/u/#{data._id}"


  $scope.getFocusedClass = (e) ->
    setTimeout ->
      $(e.target).addClass('active')
    , 0


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

  $scope.init()
