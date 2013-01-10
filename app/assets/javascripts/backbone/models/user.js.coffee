class Estimateit.Models.User extends Backbone.Model
  idAttribute: '1'
  paramRoot: 'user'
  
  defaults:
    estimation: null

class Estimateit.Collections.UsersCollection extends Backbone.Collection
  model: Estimateit.Models.User
  url: "/users"
  constructor: ->
    super
    @backboneFirebase = new BackboneFirebase @
    @fetch(success: (collection) ->
      collection.create estimation : 0
      alert collection.length
    )  
    
    
  save: =>                                                                                                                                                                                                                                                                                                                                                      
    Backbone.sync('save', @,                                                                                                                                                                                                                                                                                                                                    
          success: ->                                                                                                                                                                                                                                                                                                                                      
            console.log 'users saved!'                                                                                                                                                                                                                                                                                                                           
    )                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
      
