describe "UserFirebaseService", ->
  
  beforeEach =>
    angular.module('test',['myApp'])
    mockFirebase =
      child : (id) => mockFirebase
      set : (user) =>
      on : (eventName, callback) =>
      onDisconnect : =>
        remove: =>
    module 'test'
    inject ($rootScope) =>
      scope = $rootScope.$new()
      @service = new UserFirebaseService mockFirebase, scope
  
  it 'should have currentUser defined', =>
    expect(@service.currentUser).toBeDefined()
    
  describe 'when adding user from firebase', =>
    
    it 'when added user is not currentUser', =>
      newUser = new User("newId")
      snapshot =
        val: => newUser
      @service._onUserAdded(snapshot)
      expect(@service.users.length).toBe(1)
    
    it 'when added user is currentUser', =>
      snapshot =
        val: => @service.currentUser
      @service._onUserAdded(snapshot)
      expect(@service.users.length).toBe(0)
  
  describe 'when updating user', =>
    it 'should update changed user when its not currentUser', =>
      @service.users = [1..5].map (index) -> new User(index)
      modifiedUser = new User(@service.users[3].id, "newName")
      snapshot = 
        name: => @service.users[3].id
        val: => modifiedUser
      @service._onUserChanged(snapshot)
      expect(@service.users[3].name).toBe("newName")
    it 'should update currentUser', =>
      @service.users = [1..5].map (index) -> new User(index)
      modifiedUser = new User(@service.currentUser.id, "newName")
      snapshot = 
        name: => @service.currentUser.id
        val: => modifiedUser
      @service._onUserChanged(snapshot)
      expect(@service.currentUser.name).toBe("newName")
  
  describe 'when removing user', =>
      it 'should remove correct other user', =>
        @service.users = [1..5].map (index) -> new User(index)
        snapshot = 
          name: => @service.users[3].id
          val: => @service.users[3]
        idToRemove = @service.users[3].id
        @service._onUserRemoved(snapshot)
        expect(@service.users.length).toBe(4)
        expect(@service.users[3].id).not.toBe(idToRemove)
        
      
    