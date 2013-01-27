module = angular.module "service.userFirebase", [], ($provide) ->
  $provide.factory 'userFirebase', ['$location', ($location)->
    new UserFirebaseService($location)
  ]
class @UserFirebaseService
  constructor:($location)  ->
    console.log $location.hash()
    @url = "http://estimateit.firebaseio.com/#{$location.hash()}/users/"
  
  connect: =>
    @fb = new Firebase(@url)
    
  initialize_local_user: (user) =>
    @fb.child(user.id).set user
    @fb.child(user.id).removeOnDisconnect()
  
  on:(event_name, callback) =>
    @fb.on event_name, callback
  
  update: (user) =>
    user = angular.fromJson(angular.toJson(user))
    @fb.child(user.id).set user
     
