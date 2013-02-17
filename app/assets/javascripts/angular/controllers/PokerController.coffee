module = angular.module("controllers.poker",['service.userFirebase'])

class @PokerController
  constructor: ($scope, @userFirebase)->
    $scope.otherUsers = @userFirebase.otherUsers
    $scope.me = @userFirebase.currentUser
    
    $scope.change = (user)=>
      console.log "changed in browser"
      @userFirebase.update(user)
      $scope.safeApply()
    
    $scope.change_my_estimation = (estimate)=>
      $scope.me.estimation = estimate
      $scope.change $scope.me
    
    $scope.clear_everybody_if_everyone_ready = ->
      if $scope.everyone_ready() then $scope.clear_everybody()
      
    $scope.everyone_ready = ->
      $scope.me.estimation? and _.every($scope.otherUsers, (user) -> user.estimation?)
    
    $scope.selected_user_and_waiting_for_others = (user)->
      user.estimation? and not $scope.everyone_ready()
    
    $scope.clear_everybody = ->
      for user in $scope.otherUsers
        user.estimation = undefined
        $scope.change(user)
      $scope.me.estimation = undefined
      $scope.change($scope.me)
    
    

PokerController.$inject = ["$scope", "userFirebase"]
module.controller "PokerController", PokerController

class @User
  constructor: (@id = Math.random().toString(36).substr(2), @name="Anonymous" + Math.floor(Math.random() * 100))->
  