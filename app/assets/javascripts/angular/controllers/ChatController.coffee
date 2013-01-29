
module = angular.module('controllers.chat', ['service.user', 'service.chatFirebase'])

class @ChatController extends BaseController
  constructor:($scope, @chatFirebase, users) ->
    super($scope)
    @chatFirebase.connect()
    $scope.current_user = users.current_user
    @other_users = users.other_users
    $scope.messages = []
    
    $scope.addMessage = (message) =>
      console.log $scope.current_user
      chatFirebase.addMessage(new Message($scope.current_user.name, message))
    
    @chatFirebase.on 'child_added', (snapshot)->
      $scope.messages.push(snapshot.val())
      $scope.safeApply()
    
    
ChatController.$inject = ["$scope", "chatFirebase", "users"]
module.controller "ChatController", ChatController

class Message
  constructor:(@author = "Anonymous", @data = "") ->