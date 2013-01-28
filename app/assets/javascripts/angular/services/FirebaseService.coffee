class @FirebaseService
  constructror:($location, url_suffix) ->
    @url = "http://estimateit.firebaseio.com/#{$location.hash()}/#{url_suffix}"
    
  connect: =>
    @fb = new Firebase(@url)
    
  on:(event_name, callback) =>
    @fb.on event_name, callback