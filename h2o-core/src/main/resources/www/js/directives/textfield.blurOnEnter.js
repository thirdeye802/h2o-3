// Generated by CoffeeScript 1.5.0
(function() {
  var module;

  module = angular.module('swing.directives.textfield');

  module.directive("blurOnEnter", function() {
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        var jqElement;
        if (attrs.type === 'radio' || attrs.type === 'checkbox') {
          return;
        }
        jqElement = $(element);
        return element.bind('keydown', function(e) {
          if (e.which === 13) {
            return jqElement.blur();
          }
        });
      }
    };
  });

}).call(this);
