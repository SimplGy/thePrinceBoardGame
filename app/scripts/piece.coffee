angular.module('prince')


.factory 'Piece', ->
  _static =
    TYPES:
      prince: 'prince'
      footman: 'footman'

  Piece = (options) ->
    @type = options.type
    @x = options.x
    @y = options.y

  Piece.prototype =
    x: undefined
    y: undefined
    actions: 0 # how many actions has this piece taken?
    getSide: -> if @actions % 2 is 0 then 0 else 1 # is it on side 0 or side 1?
    move: (pos) ->
      if pos.x is @x and pos.y is @y
        return null # Already in this postion, doesn't count as a move
      else
        @x = pos.x
        @y = pos.y
        @actions++
    team: 0 # dark or light team?

  angular.extend Piece, _static



.directive 'piece', (cfg) ->
  restrict: 'A'
#  scope: piece: '='
  link: (scope, el, attrs) ->
    console.log 'piece scope', scope
    pieceSize = undefined
    draggie = new Draggabilly el[0]
    draggie.on 'dragEnd', (draggie, evt, pointer) ->
      console.warn 'can not position piece without knowing size' unless cfg.pieceSize
      col = Math.round draggie.position.x / cfg.pieceSize
      col = null if 0 < col > cfg.cellCount # out of bounds
      row = Math.round draggie.position.y / cfg.pieceSize
      row = null if 0 < row > cfg.cellCount # out of bounds
      pos =
        x: col
        y: row
      setPosition pos

    setPosition = (pos) ->
      # Turn off the top and left offset in a way that doesn't break draggabilly
      draggie.element.style.left = null
      draggie.element.style.top = null
      # Return without changing position if the position wasn't successfully calculated
      return unless pos.x? and pos.y?
      # Announce the new x/y coord to scope. It will assign the css class and css will handle the positioning
      scope.$apply ->
        scope.piece.move pos



