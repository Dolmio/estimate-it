
module = angular.module('controllers.chat', ['service.userFirebase', 'service.chatFirebase'])

class @ChatController
  constructor:($scope, chatFirebase, userFirebase) ->
    $scope.current_user = userFirebase.currentUser
    $scope.messages = chatFirebase.messages
    
    $scope.sendMessage = =>
      chatFirebase.addMessage(new Message($scope.current_user.name, $scope.message.data))
      $scope.message.data = undefined
    
    
ChatController.$inject = ["$scope", "chatFirebase", "userFirebase"]
module.controller "ChatController", ChatController

class @Message
  constructor:(@author = "Anonymous", @data = "") ->