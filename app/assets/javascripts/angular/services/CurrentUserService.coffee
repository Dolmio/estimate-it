angular.module('service.currentUser', [])
.service 'currentUser',  ->
  user = new User
  user