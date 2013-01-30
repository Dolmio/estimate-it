module = angular.module("myApp")

module.directive "scrollDown", ->
  restrict: "A"
  link: (scope, element, attrs) ->
    scope.$watch "messages", ((val) ->
      parent = element.parent()
      parent.scrollTop(parent[0].scrollHeight)
    ), true