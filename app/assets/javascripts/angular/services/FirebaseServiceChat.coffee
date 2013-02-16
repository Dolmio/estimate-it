module = angular.module "service.chatFirebase", [], ['$provide', ($provide) ->
  $provide.factory 'chatFirebase', ['$location', '$rootScope', ($location, $rootScope)->
    firebase_url = "http://estimateit.firebaseio.com/#{$location.hash()}/messages"
    new ChatFirebaseService(new Firebase(firebase_url), $rootScope)
  ]
]
class @ChatFirebaseService
  constructor:(@fb, @$rootScope) ->
    @messages = []
    
    @fb.on 'child_added', @_onMessageAdded
    
  _onMessageAdded: (snapshot) =>
    console.log "message added event"
    @messages.push snapshot.val()
    @$rootScope.safeApply()
  
  addMessage: (message) =>
    @fb.push message
        
ChatFirebaseService.$inject = ["$location", "$rootScope"]
