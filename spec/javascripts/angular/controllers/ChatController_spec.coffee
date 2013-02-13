describe "ChatController", ->
  
  beforeEach =>
    angular.module('test',['myApp', 'service.user'])
    fireMock = jasmine.createSpyObj 'fireMock', ['addMessage']
    #this marks test and ng modules for injection
    module 'test'
    inject ($rootScope, users) =>
      @scope = $rootScope.$new()
      @ctrl = new ChatController @scope , fireMock, users
  
  it 'should have user present', =>
    expect(@scope.current_user).toBeDefined()
  