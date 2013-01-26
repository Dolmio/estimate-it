#= require angular
#= require angular-mocks
#= application
describe "usersController", ->
  
  beforeEach =>
    mod = angular.module('test',[])
    fireMock = jasmine.createSpyObj 'fireMock', ['connect', 'initialize_local_user', 'on', 'update']
    module 'test'
    inject ($rootScope) =>
      @scope = $rootScope.$new()
      @ctrl = new UsersController @scope , fireMock 
      
  it "should have local user", =>
    expect(@scope.me.id).toBeDefined()
    
  it "should change local estimation", =>
    @scope.change_my_estimation(19)
    expect(@scope.me.estimation).toEqual(19)
  
  it "should allow strings in estimations", =>
    @scope.change_my_estimation("?")
    expect(@scope.me.estimation).toEqual("?")