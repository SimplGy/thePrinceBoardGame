angular.module('prince')

.factory 'PieceDefinitions', ->

  TYPES =
    prince: 'prince'
    footman: 'footman'
    pikeman: 'pikeman'
  ACTIONS =
    move: 'move'
    slide: 'slide'
    jump: 'jump'
    jumpslide: 'jumpslide'
    strike: 'strike'
    command: 'command'

  # Shortcut vars for readable action postions
#  m = ACTIONS.move
#  s = ACTIONS.slide
#  j = ACTIONS.jump
#  x = ACTIONS.strike
#  c = ACTIONS.command

  definitions =
    TYPES: TYPES
    ACTIONS: ACTIONS
    prince:
      type: TYPES.prince
      actions: [
        slide: [-1, 0], [1, 0]    #      ^
      ,                           #    < D >
        slide: [0, 1], [0, -1]    #      v
      ]
    footman:
      type: TYPES.footman
      actions: [
        move: [
          [0,-1]
          [1,0]
          [0,1]
          [-1,0]
        ]
      ,
        move: [
          [1,0]
          [0,1]
          [0,1]
          [-1,0]
        ]
      ]
#eg: footman.actions[0].move




  definitions