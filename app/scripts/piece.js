// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('prince').factory('Piece', function(cfg, gameBoard, PieceDefinitions) {
    var Piece;
    Piece = function(options) {
      var definition;
      definition = PieceDefinitions[options.type];
      if (!definition) {
        console.warn("No Piece Definition found for type: " + options.type);
      }
      angular.extend(this, definition);
      this.x = options.x;
      this.y = options.y;
      return this.team = options.team;
    };
    Piece.prototype = {
      x: void 0,
      y: void 0,
      team: void 0,
      actionCount: 0,
      selected: false,
      getSide: function() {
        if (this.actionCount % 2 === 0) {
          return 0;
        } else {
          return 1;
        }
      },
      getActions: function() {
        return this.actions[this.getSide()];
      },
      showActions: function() {
        return gameBoard.showActions(this);
      },
      selectPiece: function() {
        console.log("selected: ", this);
        return gameBoard.selectPiece(this);
      },
      movePiece: function(pos) {
        return gameBoard.movePiece(this, pos);
      },
      act: function(pos) {
        gameBoard.clearHighlights();
        if (pos.x < 0) {
          return 'off the left';
        }
        if (pos.x > cfg.cellCount - 1) {
          return 'off the right';
        }
        if (pos.y < 0) {
          return 'off the top';
        }
        if (pos.y > cfg.cellCount - 1) {
          return 'off the bottom';
        }
        if (!((pos.x != null) && (pos.y != null))) {
          return 'missing a position';
        }
        if (pos.x === this.x && pos.y === this.y) {
          return 'already in this position';
        } else {
          this.x = pos.x;
          this.y = pos.y;
          return this.actionCount++;
        }
      }
    };
    return Piece;
  }).directive('piece', function(cfg) {
    return {
      restrict: 'A',
      link: function(scope, el, attrs) {
        var draggie, setPosition;
        draggie = new Draggabilly(el[0]);
        draggie.on('dragEnd', function(draggie, evt, pointer) {
          var col, pos, row;
          if (!cfg.pieceSize) {
            console.warn('can not position piece without knowing size');
          }
          col = Math.round(draggie.position.x / cfg.pieceSize);
          row = Math.round(draggie.position.y / cfg.pieceSize);
          pos = {
            x: col,
            y: row
          };
          return setPosition(pos);
        });
        return setPosition = function(pos) {
          draggie.element.style.left = null;
          draggie.element.style.top = null;
          return scope.$apply(function() {
            return console.log(scope.piece.movePiece(pos));
          });
        };
      }
    };
  });

}).call(this);
