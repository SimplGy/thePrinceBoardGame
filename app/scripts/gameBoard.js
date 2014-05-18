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
  }).factory('gameBoard', function(cfg, Space, PieceDefinitions) {
    var gameBoard, space, x, y, _i, _j, _ref, _ref1;
    gameBoard = {
      locations: [],
      spaces: [],
      pieces: [],
      selectedPiece: null
    };
    for (x = _i = 0, _ref = cfg.cellCount; 0 <= _ref ? _i < _ref : _i > _ref; x = 0 <= _ref ? ++_i : --_i) {
      gameBoard.locations[x] = [];
      for (y = _j = 0, _ref1 = cfg.cellCount; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
        space = new Space({
          x: x,
          y: y
        });
        gameBoard.spaces.push(space);
        gameBoard.locations[x].push(space);
      }
    }
    gameBoard.clearHighlights = function() {
      var _k, _len, _ref2, _results;
      _ref2 = gameBoard.spaces;
      _results = [];
      for (_k = 0, _len = _ref2.length; _k < _len; _k++) {
        space = _ref2[_k];
        _results.push(space.highlight = false);
      }
      return _results;
    };
    gameBoard.showActions = function(piece) {
      var actions, coords, loc, offset, type, _results;
      gameBoard.clearHighlights();
      actions = piece.getActions();
      console.log('highlight actions: ', actions);
      _results = [];
      for (type in actions) {
        coords = actions[type];
        if (type === PieceDefinitions.ACTIONS.move || type === PieceDefinitions.ACTIONS.jump) {
          _results.push((function() {
            var _k, _len, _ref2, _results1;
            _results1 = [];
            for (_k = 0, _len = coords.length; _k < _len; _k++) {
              offset = coords[_k];
              x = piece.x + offset[0];
              y = piece.y + offset[1];
              loc = (_ref2 = gameBoard.locations[x]) != null ? _ref2[y] : void 0;
              if (loc) {
                _results1.push(loc.highlight = true);
              } else {
                _results1.push(void 0);
              }
            }
            return _results1;
          })());
        } else {
          _results.push(console.warn("coord display rules for type " + type + " not yet implemented"));
        }
      }
      return _results;
    };
    gameBoard.unselectCurrent = function() {
      if (gameBoard.selectedPiece) {
        gameBoard.selectedPiece.selected = false;
      }
      gameBoard.selectedPiece = null;
      return gameBoard.clearHighlights();
    };
    gameBoard.selectPiece = function(piece) {
      console.log("gb.select ", piece);
      if (gameBoard.selectedPiece) {
        gameBoard.selectedPiece.selected = false;
      }
      gameBoard.selectedPiece = piece;
      gameBoard.selectedPiece.selected = true;
      return gameBoard.selectedPiece.showActions();
    };
    gameBoard.moveSelected = function(space) {
      console.log("click space", space);
      if (gameBoard.selectedPiece) {
        if (space.highlight) {
          gameBoard.selectedPiece.act(space);
        }
        return gameBoard.unselectCurrent();
      }
    };
    gameBoard.movePiece = function(piece, pos) {
      var _ref2;
      space = (_ref2 = gameBoard.locations[pos.x]) != null ? _ref2[pos.y] : void 0;
      if (space && space.highlight) {
        return piece.act(space);
      }
    };
    gameBoard.removePiece = function(piece) {
      var index;
      index = gameBoard.pieces.indexOf(piece);
      if (index !== -1) {
        gameBoard.pieces.splice(index, 1);
        return gameBoard.clearHighlights();
      }
    };
    return gameBoard;
  }).directive('gameBoard', function(gameBoard, $window, cfg) {
    return {
      restrict: 'E',
      scope: {},
      template: '<b\n  ng-repeat="space in board.spaces"\n  class="space x{{space.x}} y{{space.y}}"\n  ng-class="{highlight: space.highlight, altColor: (space.x + space.y) % 2 === 0}"\n  ng-click="board.moveSelected(space)"\n  title="{{space.x}}, {{space.y}}">\n</b>\n\n<i piece\n   ng-repeat="piece in board.pieces"\n   ng-click="piece.selectPiece()"\n   ng-mouseover="piece.selectPiece()"\n   class="piece {{piece.type}} x{{piece.x}} y{{piece.y}} team{{piece.team}} select{{piece.selected}} side{{piece.getSide()}}">\n  {{piece.type}}\n</i>',
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
