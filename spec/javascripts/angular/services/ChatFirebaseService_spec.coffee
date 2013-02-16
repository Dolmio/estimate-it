describe "ChatFirebaseService", ->
  
  beforeEach =>
    angular.module('test',['myApp'])
    mockFirebase =
      push : (message) =>
      on : (eventType) =>
    
    module 'test'
    inject ($rootScope) =>
      scope = $rootScope.$new()
      @service = new ChatFirebaseService mockFirebase, scope
  
  describe 'adding messages', =>
    it 'should add message', =>
      newMessage = new Message("author", "message")
      snapshot =
        val: => newMessage
      @service._onMessageAdded(snapshot)
      expect(@service.messages.length).toBe(1)
      expect(@service.messages[0].data).toBe("message")
    
        
      
    