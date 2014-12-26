'use strict'

describe 'Controller: ServiceCtrl', ->

  # load the controller's module
  beforeEach module 'sociallinkApp'
  ServiceCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ServiceCtrl = $controller 'ServiceCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
