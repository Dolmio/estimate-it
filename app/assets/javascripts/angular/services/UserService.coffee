angular.module('service.user', [])
.service 'users',  ->
  user = new User
  {current_user : user, other_users : [] }