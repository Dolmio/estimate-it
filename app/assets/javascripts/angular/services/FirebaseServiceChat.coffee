module = angular.module "service.chatFirebase", [], ['$provide', ($provide) ->
  $provide.factory 'chatFirebase', ['$location', ($location)->
    new ChatFirebaseService($location)
  ]
]
class @ChatFirebaseService extends FirebaseService
  constructor:($location) ->
    super($location, "messages")
  
  addMessage: (message) ->
    @fb.push(message)
ChatFirebaseService.$inject = ["$location"]