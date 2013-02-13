module = angular.module "service.chatFirebase", [], ['$provide', ($provide) ->
  $provide.factory 'chatFirebase', ['$location', '$rootScope', ($location, $rootScope)->
    new ChatFirebaseService $location, $rootScope
  ]
]
class @ChatFirebaseService extends FirebaseService
  constructor:($location, $rootScope) ->
    super($location, "messages")
    @messages = []
    
    @fb.on 'child_added', (snapshot) =>
        console.log "message added event"
        @messages.push snapshot.val()
        $rootScope.safeApply()
  
  addMessage: (message) =>
    @fb.push message
        
ChatFirebaseService.$inject = ["$location"]