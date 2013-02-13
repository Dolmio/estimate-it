class @FirebaseService
  constructor:($location, url_suffix) ->
    @url = "http://estimateit.firebaseio.com/#{$location.hash()}/#{url_suffix}"
    @fb = new Firebase(@url)
    
    
    
  on:(event_name, callback) =>
    @fb.on event_name, callback