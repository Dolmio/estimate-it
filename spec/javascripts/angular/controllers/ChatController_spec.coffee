describe "ChatController", ->
  
  beforeEach =>
    angular.module('test',['myApp', 'service.userFirebase'])
    userFirebase = jasmine.createSpyObj 'usersMock', ['users', 'currentUser']
    userFirebase.currentUser = -> new User
    userFirebase.users = -> []
    chatFirebase = jasmine.createSpyObj 'chatMock', ['addMessage']
    chatFirebase.messages = []
    #this marks test and ng modules for injection
    module 'test'
    inject ($rootScope) =>
      @scope = $rootScope.$new()
      @ctrl = new ChatController @scope, chatFirebase, userFirebase
  
  it 'should have user present', =>
    expect(@scope.current_user).toBeDefined()
  
  it 'should clear message text after sending message', =>
    @scope.message = {}
    @scope.message.data = "message"
    @scope.sendMessage()
    expect(@scope.message.data).toBeUndefined()
    