module = angular.module "service.chatFirebase", [], ($provide) ->
  $provide.factory 'chatFirebase', ['$location', ($location)->
    new ChatFirebaseService($location)
  ]
class @ChatFirebaseService extends FirebaseService
  constructor:($location) ->
    super($location, "messages")
  
  addMessage: (author, message) ->
    @fb.push(message)

ChatFirebaseService.$inject = ["$location"]