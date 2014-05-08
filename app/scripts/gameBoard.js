// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('prince').factory('Space', function() {
    var Space;
    Space = function(location) {
      this.x = location.x;
      return this.y = location.y;
    };
    Space.prototype = {
      x: void 0,
      y: void 0
    };
    return Space;
  }).factory('gameBoard', function(cfg, Space) {
    var api, space, x, y, _i, _j, _ref, _ref1;
    api = {
      locations: [],
      spaces: [],
      pieces: []
    };
    for (y = _i = 0, _ref = cfg.cellCount; 0 <= _ref ? _i < _ref : _i > _ref; y = 0 <= _ref ? ++_i : --_i) {
      api.locations[y] = [];
      for (x = _j = 0, _ref1 = cfg.cellCount; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; x = 0 <= _ref1 ? ++_j : --_j) {
        space = new Space({
          x: x,
          y: y
        });
        api.spaces.push(space);
        api.locations[y].push;
      }
    }
    api.showActions = function(piece) {
      return console.log("Visualize these actions: ", piece.getActions());
    };
    return api;
  }).directive('gameBoard', function(gameBoard, $window, cfg) {
    return {
      restrict: 'E',
      scope: {},
      template: '<b\n  ng-repeat="space in board.spaces"\n  class="space x{{space.x}} y{{space.y}}"\n  ng-class="{altColor: (space.x + space.y) % 2 === 0}" title="{{space.x}}, {{space.y}}">\n</b>\n\n<i piece\n   ng-repeat="piece in board.pieces"\n   ng-click="onClick(piece)"\n   class="piece {{piece.type}} x{{piece.x}} y{{piece.y}} team{{piece.team}} side{{piece.getSide()}}">\n  {{piece.type}}\n</i>',
      link: function(scope, el, attrs) {
        var calculateSize;
        scope.board = gameBoard;
        calculateSize = function() {
          var size;
          if ($window.innerWidth > $window.innerHeight) {
            size = window.innerHeight;
          } else {
            size = window.innerWidth;
          }
          size = Math.floor(size);
          size -= 40;
          el.css({
            width: size,
            height: size
          });
          cfg.boardSize = size;
          return cfg.pieceSize = Math.round(size / cfg.cellCount);
        };
        $window.onresize = _.debounce(calculateSize, 200);
        return calculateSize();
      }
    };
  });

}).call(this);
