
angular.module('prince')
.factory 'Space', ->
  Space = (location) ->
    @x = location.x
    @y = location.y
  Space.prototype =
    x: undefined
    y: undefined
    highlight: ""
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
      space.highlight = ""
    for p in gameBoard.pieces
      p.attacked = ""

  # Given a piece instance, show the actions on the game board that can be made
  gameBoard.showActions = (piece) ->
    if gameBoard.selectedPiece and piece.team != gameBoard.selectedPiece.team then return
    if not piece then return
    gameBoard.clearHighlights()

    actions = piece.getActions()
    console.log 'highlight actions: ', actions, piece.team
    for type, coords of actions
      if type is PieceDefinitions.ACTIONS.move or \
         type is PieceDefinitions.ACTIONS.jump or \
         type is PieceDefinitions.ACTIONS.strike
        for offset in coords
          x = piece.x + offset[0]
          y = piece.y + offset[1]*piece.getTeamOrientation()
          # Highlight the location, if it's on the board
          loc = gameBoard.locations[x]?[y]
          if loc
            loc.highlight = type
            for p in gameBoard.pieces
              if p.x is loc.x and p.y is loc.y
                if p.team is piece.team
                  loc.highlight = ""
                else
                  p.attacked = type
            console.log "loc", loc
      else
        console.warn "coord display rules for type #{type} not yet implemented"

  gameBoard.getSpace = (x,y) ->
    return gameBoard.locations[x]?[y]

  gameBoard.unselectCurrent = ->
    if gameBoard.selectedPiece
      gameBoard.selectedPiece.selected = false
    gameBoard.selectedPiece = null
    gameBoard.clearHighlights()

  # Select the given piece and show the actions or remove it if attacked
  gameBoard.selectPiece = (piece) ->
    console.log "gb.select ", piece
    if piece.attacked isnt ""
      gameBoard.selectedPiece.act gameBoard.getSpace(piece.x, piece.y)
      gameBoard.removePiece(piece)
      gameBoard.selectedPiece.showActions()
      return
    if gameBoard.selectedPiece
      gameBoard.selectedPiece.selected = false
    gameBoard.selectedPiece = piece
    gameBoard.selectedPiece.selected = true
    gameBoard.selectedPiece.showActions()

  # Move the selected piece in case the given space is highlighted
  # Unselect it afterward or in any other case
  gameBoard.clickSpace = (space) ->
    console.log "click space", space
    if gameBoard.selectedPiece
      if space.highlight isnt ""
        gameBoard.selectedPiece.act space
        return
      gameBoard.unselectCurrent()

  # Try to move the given piece on the given space
  # Move is allowed if space is highlighted
  gameBoard.movePiece = (piece, pos) ->
    space = gameBoard.getSpace(pos.x,pos.y)
    if space and space.highlight in [PieceDefinitions.ACTIONS.move, PieceDefinitions.ACTIONS.jump]
      piece.act space
    for p in gameBoard.pieces
      if p.x is pos.x and p.y is pos.y and p.attacked
        console.log "attack", p.x, p.y, p.definition
        gameBoard.removePiece(p)
        return
    
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
  template: '<b\n  ng-repeat="space in board.spaces"\n  class="space x{{space.x}} y{{space.y}} highlight{{space.highlight}}"\n  ng-class="{altColor: (space.x + space.y) % 2 === 0}"\n  ng-click="board.clickSpace(space)"\n  title="{{space.x}}, {{space.y}}">\n</b>\n\n<i piece\n   ng-repeat="piece in board.pieces"\n   ng-click="piece.selectPiece()"\n   ng-mouseover="piece.showActions()"\n   ng-mouseleave="board.selectedPiece.showActions()"\n   class="piece {{piece.type}} x{{piece.x}} y{{piece.y}} team{{piece.team}} select{{piece.selected}} attacked{{piece.attacked}} side{{piece.getSide()}}">\n  {{piece.type}}\n</i>'
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








