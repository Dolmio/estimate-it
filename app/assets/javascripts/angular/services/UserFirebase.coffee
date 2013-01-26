module = angular.module "service.userFirebase", [] 
module.factory 'userFirebase', ->
  new UserFirebaseService
  
class UserFirebaseService
  constructor:  ->
    url = "http://estimateit.firebaseio.com/#{window.location.pathname}/users/"
    @fb = new Firebase(url)
    
  initialize_local_user: (user) =>
    @fb.child(user.id).set user
    @fb.child(user.id).removeOnDisconnect()
  
  on:(event_name, callback) =>
    @fb.on event_name, callback
  
  update: (user) ->
    user = angular.fromJson(angular.toJson(user))
    @fb.child(user.id).set user
     
     