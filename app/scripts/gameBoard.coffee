
angular.module('prince')
.factory 'Space', ->
  Space = (location) ->
    @x = location.x
    @y = location.y
  Space.prototype =
    x: undefined
    y: undefined
  Space

#.directive 'space', ->
#    restrict: 'E'
#    scope: {}
#    replace: true
#    template: '<b class="space x{{x}} y{{y}}"></b>'
#    link: (scope, el, attrs) ->
#      console.log scope:scope


# Build a game board with instances of space objects
.factory 'gameBoard', (cfg, Space) ->
  api =
    locations: []  # 2d array representing board shape
    spaces: []     # Flat list
    pieces: []

  for y in [0...cfg.cellCount]
    api.locations[y] = []
    for x in [0...cfg.cellCount]
      space = new Space x:x, y:y
      api.spaces.push space
      api.locations[y].push

  # Given a piece instance, show the actions on the game board that can be made
  api.showActions = (piece) ->
    console.log "Show actions for piece: ", piece

  api


.directive 'gameBoard', (gameBoard, $window, cfg) ->
  restrict: 'E'
  scope: {}
  template: '<b\n  ng-repeat="space in board.spaces"\n  class="space x{{space.x}} y{{space.y}}"\n  ng-class="{altColor: (space.x + space.y) % 2 === 0}" title="{{space.x}}, {{space.y}}">\n</b>\n\n<i piece\n   ng-repeat="piece in board.pieces"\n   ng-click="onClick(piece)"\n   class="piece {{piece.type}} x{{piece.x}} y{{piece.y}} team{{piece.team}} side{{piece.getSide()}}">\n  {{piece.type}}\n</i>'
  link: (scope, el, attrs) ->
    scope.board = gameBoard
    calculateSize = ->
      if $window.innerWidth > $window.innerHeight
        size = window.innerHeight
      else
        size = window.innerWidth
      size = Math.floor size
      size -= 40
      el.css
        width: size
        height: size
      cfg.boardSize = size
      cfg.pieceSize = Math.round size / cfg.cellCount
    $window.onresize = _.debounce calculateSize, 200
    do calculateSize








