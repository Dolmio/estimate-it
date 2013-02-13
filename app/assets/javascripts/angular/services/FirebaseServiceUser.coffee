module = angular.module "service.userFirebase", [],['$provide', ($provide) ->
  $provide.factory 'userFirebase', ['$location', ($location)->
    new UserFirebaseService($location)
  ]
]
class @UserFirebaseService extends FirebaseService
  constructor:($location)  ->
    super($location, "users")
  
  initialize_local_user: (user) =>
    @fb.child(user.id).set user
    @fb.child(user.id).onDisconnect().remove()
  
  update: (user) =>
    user = angular.fromJson(angular.toJson(user))
    @fb.child(user.id).set user
     
UserFirebaseService.$inject = ["$location"]