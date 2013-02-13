describe 'ApplicationController', ->
  beforeEach =>
    angular.module('test',['myApp'])
    module 'test'
  
  it "when no predifined hash", ->
    inject ($location) =>
      ctrl = new ApplicationController $location
      expect($location.hash()).not.toBe("")
  it "when predifined hash", ->
    inject ($location) =>
      $location.hash("hash")
      ctrl = new ApplicationController $location
      expect($location.hash()).toBe("hash")
    