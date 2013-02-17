app = angular.module 'myApp', ['controllers.poker', 'controllers.chat'], ['$provide', ($provide) ->
  $provide.decorator '$rootScope', ['$delegate', ($rootScope) -> 
    $rootScope.safeApply = (fn) ->
      phase = @$root.$$phase
      if phase is "$apply" or phase is "$digest"
        fn()  if fn and (typeof (fn) is "function")
      else
        @$apply fn
    $rootScope
  ]
]

class @ApplicationController
  constructor:($location) ->
    if $location.hash() is "" then $location.hash Math.random().toString(36).substr(2)
ApplicationController.$inject = ["$location"]
app.controller "ApplicationController", ApplicationController


  
