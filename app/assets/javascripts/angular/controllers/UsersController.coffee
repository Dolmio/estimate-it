module = angular.module("myApp",['service.userFirebase'])


class UsersController
  constructor: ($scope, userFirebase)->
    
    $scope.users = []
    $scope.me = new User
    userFirebase.initialize_local_user($scope.me)
    
    userFirebase.on "child_added", (snapshot) =>
      console.log "added child"
      #dont push ourselves to users
      if snapshot.val().id isnt $scope.me.id
         $scope.users.push snapshot.val()
      $scope.safeApply()
    
    userFirebase.on "child_changed", (snapshot) =>
      console.log "change"
      dirty_other_user = _.find($scope.users, (user) -> user.id is snapshot.name())
      if not dirty_other_user? and $scope.me.id is snapshot.name()
        $scope.me = angular.fromJson(snapshot.val())
      else  
        $scope.users[_.indexOf($scope.users, dirty_other_user)] = angular.fromJson(snapshot.val())
      $scope.safeApply()
    
    userFirebase.on "child_removed", (snapshot) =>
      console.log "child removed"
      user_to_delete = _.find($scope.users, (user) -> user.id is snapshot.name())
      index_to_remove = _.indexOf $scope.users, user_to_delete
      $scope.users.splice index_to_remove, 1
      $scope.safeApply()
    
    
    $scope.change = (user)=>
      console.log "changed in browser"
      userFirebase.update(user)
    
    $scope.change_estimation=(estimate)=>
      $scope.me.estimation = estimate
      $scope.safeApply()
      $scope.change $scope.me
    
    $scope.clear_everybody_if_ready = ->
      if $scope.everyone_ready() then $scope.clear_everybody() else false
      
    $scope.everyone_ready = ->
      $scope.me.estimation? and _.every($scope.users, (user) -> user.estimation?)
    
    $scope.selected_user_and_waiting_for_others = (user)->
      user.estimation? and not $scope.everyone_ready()
    
    $scope.clear_everybody = ->
      for user in $scope.users
        user.estimation = undefined
        $scope.change(user)
      $scope.me.estimation = undefined
      $scope.change($scope.me)
    
    $scope.safeApply = (fn) ->
      phase = @$root.$$phase
      if phase is "$apply" or phase is "$digest"
        fn()  if fn and (typeof (fn) is "function")
      else
        @$apply fn

UsersController.$inject = ["$scope", "userFirebase"]
module.controller "UsersController", UsersController

class User
  constructor: (@id = @generateUUID())->
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