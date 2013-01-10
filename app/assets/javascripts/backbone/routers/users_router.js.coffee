class Estimateit.Routers.UsersRouter extends Backbone.Router
  initialize: (options) ->
    
    @users = new Estimateit.Collections.UsersCollection
    #@users.reset()
    #@users.create estimation : 5
    
    
    
    #user = new Estimateit.Models.User(5)
    #user.url = "user"
    #user.save()
    #user.sync()
    #console.log @users.models
    #@users.initialize()
    #@users.save()
    
    #for model in @users.models
      #console.log model.estimation 
      #model.save()
      
    #@users.reset options.users
###
  routes:
    "/new"      : "newUser"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"
  newUser: ->
    @view = new Estimateit.Views.Users.NewView(collection: @users)
    $("#users").html(@view.render().el)

  index: ->
    @view = new Estimateit.Views.Users.IndexView(users: @users)
    $("#users").html(@view.render().el)

  show: (id) ->
    user = @users.get(id)

    @view = new Estimateit.Views.Users.ShowView(model: user)
    $("#users").html(@view.render().el)

  edit: (id) ->
    user = @users.get(id)

    @view = new Estimateit.Views.Users.EditView(model: user)
    $("#users").html(@view.render().el)
###