#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

$ = jQuery
window.Estimateit =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    new Estimateit.Routers.UsersRouter
$(document).ready ->
  Estimateit.init()
  