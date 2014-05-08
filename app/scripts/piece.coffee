angular.module('prince')


.factory 'Piece', (cfg, PieceDefinitions) ->

  Piece = (options) ->
    @type = options.type
    @x = options.x
    @y = options.y

  Piece.prototype =
    x: undefined
    y: undefined
    actions: 0 # how many actions has this piece taken?
    getSide: -> if @actions % 2 is 0 then 0 else 1 # is it on side 0 or side 1?
    act: (pos) ->
      return 'off the left'   if pos.x < 0                    # Off the left side
      return 'off the right'  if pos.x > cfg.cellCount - 1    # Too far right
      return 'off the top'    if pos.y < 0                    # Off the top
      return 'off the bottom' if pos.y > cfg.cellCount - 1    # Off the bottom
      unless pos.x? and pos.y?
        return 'missing a position'
      if pos.x is @x and pos.y is @y
        return 'already in this position'
      else
        @x = pos.x
        @y = pos.y
        @actions++
    team: 0 # dark or light team?

  Piece



.directive 'piece', (cfg) ->
  restrict: 'A'
  link: (scope, el, attrs) ->
    draggie = new Draggabilly el[0]
    draggie.on 'dragEnd', (draggie, evt, pointer) ->
      console.warn 'can not position piece without knowing size' unless cfg.pieceSize
      col = Math.round draggie.position.x / cfg.pieceSize
      row = Math.round draggie.position.y / cfg.pieceSize
      pos =
        x: col
        y: row
      setPosition pos

    setPosition = (pos) ->
      # Turn off the top and left offset in a way that doesn't break draggabilly
      draggie.element.style.left = null
      draggie.element.style.top = null
      # Announce the new x/y coord to scope. It will assign the css class and css will handle the positioning
      scope.$apply ->
        console.log scope.piece.act pos



