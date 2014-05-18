
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
    selectedPiece: null

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
      if type is PieceDefinitions.ACTIONS.move or type is PieceDefinitions.ACTIONS.jump
        for offset in coords
          x = piece.x + offset[0]
          y = piece.y + offset[1]
          # Highlight the location, if it's on the board
          loc = gameBoard.locations[x]?[y]
          if loc then loc.highlight = true
      else
        console.warn "coord display rules for type #{type} not yet implemented"

  gameBoard.unselectCurrent = ->
    if gameBoard.selectedPiece
      gameBoard.selectedPiece.selected = false
    gameBoard.selectedPiece = null
    gameBoard.clearHighlights()

  # Select the given piece and show the actions
  gameBoard.selectPiece = (piece) ->
    console.log "gb.select ", piece
    if gameBoard.selectedPiece
      gameBoard.selectedPiece.selected = false
    gameBoard.selectedPiece = piece
    gameBoard.selectedPiece.selected = true
    gameBoard.selectedPiece.showActions()

  # Move the selected piece in case the given space is highlighted
  # Unselect it afterward or in any other case
  gameBoard.moveSelected = (space) ->
    console.log "click space", space
    if gameBoard.selectedPiece
      if space.highlight
        gameBoard.selectedPiece.act space
      gameBoard.unselectCurrent()

  # Try to move the given piece on the given space
  # Move is allowed if space is highlighted
  gameBoard.movePiece = (piece, pos) ->
    space = gameBoard.locations[pos.x]?[pos.y]
    if space and space.highlight
      piece.act space
    
  # Remove the given piece
  gameBoard.removePiece = (piece) ->
    index = gameBoard.pieces.indexOf(piece)
    if index != -1
      gameBoard.pieces.splice(index,1); 
      gameBoard.clearHighlights()
  gameBoard


.directive 'gameBoard', (gameBoard, $window, cfg) ->
  restrict: 'E'
  scope: {}
  template: '<b\n  ng-repeat="space in board.spaces"\n  class="space x{{space.x}} y{{space.y}}"\n  ng-class="{highlight: space.highlight, altColor: (space.x + space.y) % 2 === 0}"\n  ng-click="board.moveSelected(space)"\n  title="{{space.x}}, {{space.y}}">\n</b>\n\n<i piece\n   ng-repeat="piece in board.pieces"\n   ng-click="piece.selectPiece()"\n   ng-mouseover="piece.selectPiece()"\n   class="piece {{piece.type}} x{{piece.x}} y{{piece.y}} team{{piece.team}} select{{piece.selected}} side{{piece.getSide()}}">\n  {{piece.type}}\n</i>'
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








