
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


.factory 'gameBoard', (cfg, Space) ->
  api = {}

  initialize = ->
    api.locations = []  # 2d array representing board shape
    api.spaces = []     # Flat list
    for y in [0...cfg.boardSize]
      api.locations[y] = []
      for x in [0...cfg.boardSize]
        space = new Space x:x, y:y
        api.spaces.push space
        api.locations[y].push

  initialize()
  api


.directive 'gameBoard', (gameBoard, $window) ->
  restrict: 'E'
  scope: {}
  template: '<b ng-repeat="space in board.spaces" class="space x{{space.x}} y{{space.y}}">{{space.x}}, {{space.y}}</b>'
  link: (scope, el, attrs) ->
    scope.board = gameBoard
    #    for space in board
    console.log scope:scope

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
    $window.onresize = _.debounce calculateSize, 200
    do calculateSize





