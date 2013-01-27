app = angular.module 'myApp', ['controllers']
class @ApplicationController
  constructor:($location) ->
    if $location.hash() is "" then $location.hash Math.random().toString(36).substr(2)
ApplicationController.$inject = ["$location"]
app.controller "ApplicationController", ApplicationController