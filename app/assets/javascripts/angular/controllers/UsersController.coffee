module = angular.module("myApp",[])


class UsersController
  constructor: ($scope)->
    firebase_url = "http://estimateit.firebaseio.com/#{window.location.pathname}/users/"
    @firebase = new Firebase firebase_url
    $scope.users = []
    $scope.me = new User
    @new_user_promise($scope).then((location) -> location.removeOnDisconnect())
    
    
    @firebase.on "child_added", (snapshot) =>
      user = snapshot.val()
      console.log "added child"
      new_user = new User(snapshot.name(), user.estimation)
      #regognize ourselves based on id
      if user.id is $scope.me.id
        $scope.me = new_user
      else
        $scope.users.push new_user
      $scope.safeApply()
    
    
    @firebase.on "child_changed", (snapshot) =>
      console.log "change"
      console.log snapshot.name()
      dirty_user = _.find($scope.users, (user) -> user.id is snapshot.name())
      $scope.users[_.indexOf($scope.users, dirty_user)] = angular.fromJson(snapshot.val())
      $scope.safeApply()
    
    @firebase.on "child_removed", (snapshot) =>
      console.log "child removed"
      console.log $scope.users
      console.log snapshot.name()
      user_to_delete = _.find($scope.users, (user) -> user.id is snapshot.name())
      index_to_remove = _.indexOf $scope.users, user_to_delete
      $scope.users.splice index_to_remove, 1
      $scope.safeApply()
    
    
    $scope.change = (user)=>
      console.log "changed in browser"
      #filter angular specific trash from object
      user = angular.fromJson(angular.toJson(user))
      @firebase.child(user.id).set user
    
    $scope.change_estimation=(estimate)=>
      $scope.me.estimation = estimate
      $scope.me.selected = true
      $scope.change $scope.me
      
    $scope.everyone_ready = ->
      $scope.me.selected and _.every($scope.users, (user) -> user.selected)
    
    $scope.selected_user_and_waiting_for_others = (user)->
      console.log "USER SELECTED: #{user.selected}"
      console.log "EVERYONE READY: #{$scope.everyone_ready()}"
      user.selected and not $scope.everyone_ready()
    $scope.safeApply = (fn) ->
      phase = @$root.$$phase
      if phase is "$apply" or phase is "$digest"
        fn()  if fn and (typeof (fn) is "function")
      else
        @$apply fn
      
  new_user_promise:($scope) ->
    deferred = Q.defer()
    location = @firebase.push $scope.me, (success)->
      if success
        deferred.resolve location
      else
        deferred.reject "creating new user failed"
    deferred.promise
    
UsersController.$inject = ["$scope"]
module.controller "UsersController", UsersController

class User
  constructor: (@id = @generateUUID(), @estimation = -1, @selected = false, @open = false)->
  #from stackoverflow...
  #So we can recognize ourselves  
  generateUUID: ->
    d = new Date().getTime()
    uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, (c) ->
      r = (d + Math.random() * 16) % 16 | 0
      d = Math.floor(d / 16)
      ((if c is "x" then r else (r & 0x7 | 0x8))).toString 16
    )
    uuid