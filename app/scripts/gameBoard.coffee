
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
.factory 'gameBoard', (cfg, Space, PieceDefinitions) ->
  gameBoard =
    locations: []  # 2d array representing board shape
    spaces: []     # Flat list
    pieces: []

  for x in [0...cfg.cellCount]
    gameBoard.locations[x] = []
    for y in [0...cfg.cellCount]
      space = new Space x:x, y:y
      gameBoard.spaces.push space
      gameBoard.locations[x].push space # putting the same reference in both structures allows it to be referenced either way

  # Clear all the highlights on the board
  gameBoard.clearHighlights = ->
    for space in gameBoard.spaces
      space.highlight = false

  # Given a piece instance, show the actions on the game board that can be made
  gameBoard.showActions = (piece) ->
    gameBoard.clearHighlights()
    actions = piece.getActions()
    console.log 'highlight actions: ', actions
    for type, coords of actions
      if type is PieceDefinitions.ACTIONS.move
        for offset in coords
          x = piece.x + offset[0]
          y = piece.y + offset[1]
          # Highlight the location, if it's on the board
          loc = gameBoard.locations[x]?[y]
          if loc then loc.highlight = true
      else
        console.warn "coord display rules for type #{type} not yet implemented"

  gameBoard


.directive 'gameBoard', (gameBoard, $window, cfg) ->
  restrict: 'E'
  scope: {}
  template: '<b\n  ng-repeat="space in board.spaces"\n  class="space x{{space.x}} y{{space.y}}"\n  ng-class="{highlight: space.highlight, altColor: (space.x + space.y) % 2 === 0}"\n  title="{{space.x}}, {{space.y}}">\n</b>\n\n<i piece\n   ng-repeat="piece in board.pieces"\n   ng-mousedown="piece.showActions()"\n   class="piece {{piece.type}} x{{piece.x}} y{{piece.y}} team{{piece.team}} side{{piece.getSide()}}">\n  {{piece.type}}\n</i>'
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








