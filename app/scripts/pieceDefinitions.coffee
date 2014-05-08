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
      actions: [                  #     #
        slide: [-1, 0], [1, 0]    #  ^  #
      ,                           # <D> #
        slide: [0, 1], [0, -1]    #  v  #
      ]                           #     #
                                  
    footman:
      type: TYPES.footman
      actions: [
        move: [                   #     #
          [0,-1]                  #  .  #
          [1,0]                   # .F. #
          [0,1]                   #  .  #
          [-1,0]                  #     #
        ]                         
      ,
        move: [                   #  .  #
          [0,-2]                  # . . #
          [-1,-1]                 #  F  #
          [1,1]                   # . . #
          [-1,1]                  #     #
          [1,-1]
        ]       
      ]

    pikeman:
      type: TYPES.pikeman
      actions: [
        move: [                   #.   .#
          [-2,-2]                 # . . #
          [-1,-1]                 #  P  #
          [1,-1]                  #     #
          [2,-2]                  #     #
        ]                         
      ,
        move: [                   # * * #
          [0,-1]                  #  .  #
          [0,1]                   #  P  #
          [0,2]                   #  .  #
                                  #  .  #
        ]
        strike: [
          [-1,-2]
          [1,-2]
        ]
      ]
#eg: footman.actions[0].move




  definitions