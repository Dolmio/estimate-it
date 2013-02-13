module = angular.module("controllers",['service.userFirebase', 'service.user'])

class @UsersController
  constructor: ($scope, @userFirebase, users)->
    $scope.users = users.other_users
    $scope.me = users.current_user
    
    @userFirebase.initialize_local_user($scope.me)
  
    @userFirebase.on "child_added", (snapshot) =>
      console.log "added child"
      #dont push ourselves to users
      if snapshot.val().id isnt $scope.me.id
        $scope.users.push snapshot.val()
      $scope.safeApply()
    
    @userFirebase.on "child_changed", (snapshot) =>
      console.log "change"
      dirty_other_user = _.find($scope.users, (user) -> user.id is snapshot.name())
      if not dirty_other_user? and $scope.me.id is snapshot.name()
        $scope.me = angular.fromJson(snapshot.val())
      else
        $scope.users[_.indexOf($scope.users, dirty_other_user)] = angular.fromJson(snapshot.val())
      $scope.safeApply()
    
    @userFirebase.on "child_removed", (snapshot) =>
      console.log "child removed"
      user_to_delete = _.find($scope.users, (user) -> user.id is snapshot.name())
      index_to_remove = _.indexOf $scope.users, user_to_delete
      $scope.users.splice index_to_remove, 1
      $scope.safeApply()
    
 
    $scope.change = (user)=>
      console.log "changed in browser"
      @userFirebase.update(user)
      $scope.safeApply()
    
    $scope.change_my_estimation=(estimate)=>
      $scope.me.estimation = estimate
      $scope.change $scope.me
    
    $scope.clear_everybody_if_everyone_ready = ->
      if $scope.everyone_ready() then $scope.clear_everybody()
      
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
    
    

UsersController.$inject = ["$scope", "userFirebase", "users"]
module.controller "UsersController", UsersController

class @User
  constructor: (@id = Math.random().toString(36).substr(2), @name="Anonymous" + Math.floor(Math.random() * 100))->
  