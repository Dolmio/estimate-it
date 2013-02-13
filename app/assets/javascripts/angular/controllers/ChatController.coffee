
module = angular.module('controllers.chat', ['service.user', 'service.chatFirebase'])

class @ChatController
  constructor:($scope, @chatFirebase, users) ->
    $scope.chatFirebase = @chatFirebase
    $scope.current_user = users.current_user
    @other_users = users.other_users
    $scope.messages = @chatFirebase.messages
    
    $scope.addMessage = (message) =>
      @chatFirebase.addMessage(new Message($scope.current_user.name, message))
    
    
ChatController.$inject = ["$scope", "chatFirebase", "users"]
module.controller "ChatController", ChatController

class Message
  constructor:(@author = "Anonymous", @data = "") ->