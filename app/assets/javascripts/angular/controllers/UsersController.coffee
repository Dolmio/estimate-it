module = angular.module("myApp",[])
firebase_url = "http://estimateit.firebaseio.com/users/"
#angular.module('module').controller 'UsersController,' ($scope) -
class UsersController
  constructor: (@$scope, $timeout)->
    @firebase = new Firebase firebase_url
    @$scope.users = []
    @firebase.push new User
    @firebase.on "child_added", (snapshot) =>
      user = snapshot.val()
      console.log user
      console.log "added"
      $timeout =>
        @$scope.users.push(new User(snapshot.name(), user.estimation))
      , 0
    
    
    @firebase.on "child_changed", (snapshot) =>
      console.log "change"
      $timeout =>
        console.log snapshot.name()
        dirty_user = _.find(@$scope.users, (user) -> user.id == snapshot.name())
        @$scope.users[_.indexOf(@$scope.users, dirty_user)] = angular.fromJson(snapshot.val())
      , 0
    
    
    @$scope.change = (user)=>
      console.log "changed in browser"
      user = angular.fromJson(angular.toJson(user))
      console.log user
      
      @firebase.child(user.id).set(user)
    
    
UsersController.$inject = ["$scope", "$timeout"]
module.controller "UsersController", UsersController

class User
  constructor: (@id = 0, @estimation = 0)->
    
