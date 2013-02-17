module = angular.module "service.userFirebase", [],['$provide', ($provide) ->
  $provide.factory 'userFirebase', ['$location', '$rootScope', ($location, $rootScope)->
    firebase_url = "http://estimateit.firebaseio.com/#{$location.hash()}/otherUsers"
    new UserFirebaseService(new Firebase(firebase_url), $rootScope)
  ]
]
class @UserFirebaseService
  constructor:(@fb, @$rootScope)  ->
    @otherUsers = []
    @currentUser = new User
    @_initializeCurrentUser()
    
    @fb.on "child_added", @_onUserAdded
    @fb.on "child_changed", @_onUserChanged  
    @fb.on "child_removed", @_onUserRemoved
      
  
  _initializeCurrentUser: =>
    @fb.child(@currentUser.id).set @currentUser
    @fb.child(@currentUser.id).onDisconnect().remove()
  
  _onUserAdded: (snapshot) =>
    console.log "added child"
    if snapshot.val().id isnt @currentUser.id
      @otherUsers.push snapshot.val()
    @$rootScope.safeApply()
  
  _onUserChanged: (snapshot) =>
    console.log "change"
    dirty_other_user = _.find(@otherUsers, (user) -> user.id is snapshot.name())
    if not dirty_other_user? and @currentUser.id is snapshot.name()
      @currentUser = angular.fromJson(snapshot.val())
    else
      @otherUsers[_.indexOf(@otherUsers, dirty_other_user)] = angular.fromJson(snapshot.val())
    @$rootScope.safeApply()
  
  _onUserRemoved: (snapshot) =>
    console.log "child removed"
    user_to_delete = _.find(@otherUsers, (user) -> user.id is snapshot.name())
    index_to_remove = _.indexOf @otherUsers, user_to_delete
    @otherUsers.splice index_to_remove, 1
    @$rootScope.safeApply()
    
  update: (user) =>
    user = angular.fromJson(angular.toJson(user))
    @fb.child(user.id).set user
    
  
     
UserFirebaseService.$inject = ["$location"]
