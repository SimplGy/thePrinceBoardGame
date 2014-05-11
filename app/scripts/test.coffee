angular.module('prince')

.factory 'PieceDefinitions', ->

  TYPES = 
    prince:'prince'
    footman:'footman'
    pikeman:'pikeman'
    bowman:'bowman'
    champion:'champion'
    dragoon:'dragoon'
    assassin:'assassin'
    general:'general'
    knight:'knight'
    marshall:'marshall'
    priest:'priest'
    seer:'seer'
    wizard:'wizard'
    oracle:'oracle'
    duchess:'duchess'
  ACTIONS = 
    move: 'move'
    slide: 'slide'
    jump: 'jump'
    jumpslide: 'jumpslide'
    strike: 'strike'
    command: 'command'

  definitions =
    TYPES: TYPES
    ACTIONS: ACTIONS
    prince:
      type: TYPES.prince
      actions: [
        slide: [
          [-1,0]
          [1,0]
        ]
      ,
        slide: [
          [0,-1]
          [0,1]
        ]
      ]

    footman:
      type: TYPES.footman
      actions: [
        move: [
          [0,-1]
          [-1,0]
          [1,0]
          [0,1]
        ]
      ,
        move: [
          [0,-2]
          [-1,-1]
          [1,-1]
          [-1,1]
          [1,1]
        ]
      ]

    pikeman:
      type: TYPES.pikeman
      actions: [
        move: [
          [-2,-2]
          [2,-2]
          [-1,-1]
          [1,-1]
        ]
      ,
        strike: [
          [-1,-2]
          [1,-2]
        ]
        move: [
          [0,-1]
          [0,1]
          [0,2]
        ]
      ]

    bowman:
      type: TYPES.bowman
      actions: [
        jump: [
          [-2,0]
          [2,0]
          [0,2]
        ]
        move: [
          [0,-1]
          [-1,0]
          [1,0]
        ]
      ,
        strike: [
          [0,-2]
          [-1,-1]
          [1,-1]
        ]
        move: [
          [0,-1]
          [-1,1]
          [1,1]
        ]
      ]

    champion:
      type: TYPES.champion
      actions: [
        jump: [
          [0,-2]
          [-2,0]
          [2,0]
          [0,2]
        ]
        move: [
          [0,-1]
          [-1,0]
          [1,0]
          [0,1]
        ]
      ,
        jump: [
          [0,-2]
          [-2,0]
          [2,0]
          [0,2]
        ]
        strike: [
          [0,-1]
          [-1,0]
          [1,0]
          [0,1]
        ]
      ]

    dragoon:
      type: TYPES.dragoon
      actions: [
        strike: [
          [-2,-2]
          [0,-2]
          [2,-2]
        ]
        move: [
          [-1,0]
          [1,0]
        ]
      ,
        jump: [
          [-1,-2]
          [1,-2]
        ]
        slide: [
          [-1,1]
          [1,1]
        ]
        move: [
          [0,-2]
          [0,-1]
        ]
      ]

    assassin:
      type: TYPES.assassin
      actions: [
        jumpslide: [
          [0,-2]
          [-2,2]
          [2,2]
        ]
      ,
        jumpslide: [
          [-2,-2]
          [2,-2]
          [0,2]
        ]
      ]

    general:
      type: TYPES.general
      actions: [
        jump: [
          [-1,-2]
          [1,-2]
        ]
        move: [
          [0,-1]
          [-2,0]
          [2,0]
          [0,1]
        ]
      ,
        jump: [
          [-1,-2]
          [1,-2]
        ]
        move: [
          [0,-1]
          [-2,0]
          [-1,0]
          [1,0]
          [2,0]
        ]
        command: [
          [-1,0]
          [1,0]
          [-1,1]
          [0,1]
          [1,1]
        ]
      ]

    knight:
      type: TYPES.knight
      actions: [
        jump: [
          [-1,-2]
          [1,-2]
        ]
        move: [
          [-2,0]
          [2,0]
          [0,1]
          [0,2]
        ]
      ,
        slide: [
          [0,-1]
        ]
        move: [
          [-1,1]
          [1,1]
          [-2,2]
          [2,2]
        ]
      ]

    marshall:
      type: TYPES.marshall
      actions: [
        jump: [
          [-2,-2]
          [2,-2]
          [0,2]
        ]
        slide: [
          [-1,0]
          [1,0]
        ]
      ,
        move: [
          [-1,-1]
          [0,-1]
          [1,-1]
          [-2,0]
          [-1,0]
          [1,0]
          [2,0]
          [-1,1]
          [1,1]
        ]
        command: [
          [-1,-1]
          [0,-1]
          [1,-1]
        ]
      ]

    priest:
      type: TYPES.priest
      actions: [
        slide: [
          [-1,-1]
          [1,-1]
          [-1,1]
          [1,1]
        ]
      ,
        jump: [
          [-2,-2]
          [2,-2]
          [-2,2]
          [2,2]
        ]
        move: [
          [-1,-1]
          [1,-1]
          [-1,1]
          [1,1]
        ]
      ]

    seer:
      type: TYPES.seer
      actions: [
        jump: [
          [0,-2]
          [-2,0]
          [2,0]
          [0,2]
        ]
        move: [
          [-1,-1]
          [1,-1]
          [-1,1]
          [1,1]
        ]
      ,
        jump: [
          [-2,-2]
          [2,-2]
          [-2,2]
          [2,2]
        ]
        move: [
          [0,-1]
          [-1,0]
          [1,0]
          [0,1]
        ]
      ]

    wizard:
      type: TYPES.wizard
      actions: [
        move: [
          [-1,-1]
          [0,-1]
          [1,-1]
          [-1,0]
          [1,0]
          [-1,1]
          [0,1]
          [1,1]
        ]
      ,
        jump: [
          [-2,-2]
          [2,-2]
          [-2,0]
          [2,0]
          [-2,2]
          [2,2]
        ]
      ]

    oracle:
      type: TYPES.oracle
      actions: [
        move: [
          [-1,-1]
          [1,-1]
          [-1,1]
          [1,1]
        ]
      ,
      ]

    duchess:
      type: TYPES.duchess
      actions: [
        move: [
          [-1,0]
          [1,0]
          [0,2]
        ]
        command: [
          [-2,0]
          [-1,0]
          [1,0]
          [2,0]
        ]
      ,
        move: [
          [-1,0]
          [1,0]
          [0,2]
        ]
        command: [
          [-2,0]
          [-1,0]
          [1,0]
          [2,0]
        ]
      ]

  definitions



  &.prince:before
    content: "P"
  &.footman:before
    content: "F"
  &.pikeman:before
    content: "Pi"
  &.bowman:before
    content: "B"
  &.champion:before
    content: "C"
  &.dragoon:before
    content: "D"
  &.assassin:before
    content: "A"
  &.general:before
    content: "G"
  &.knight:before
    content: "K"
  &.marshall:before
    content: "M"
  &.priest:before
    content: "Pr"
  &.seer:before
    content: "S"
  &.wizard:before
    content: "W"
  &.oracle:before
    content: "O"
  &.duchess:before
    content: "Du"


gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.prince
  x:0
  y:0

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.footman
  x:1
  y:0

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.pikeman
  x:2
  y:0

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.bowman
  x:3
  y:0

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.champion
  x:4
  y:0

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.dragoon
  x:5
  y:0

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.assassin
  x:0
  y:1

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.general
  x:1
  y:1

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.knight
  x:2
  y:1

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.marshall
  x:3
  y:1

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.priest
  x:4
  y:1

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.seer
  x:5
  y:1

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.wizard
  x:0
  y:2

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.oracle
  x:1
  y:2

gameBoard.pieces.push new Piece
  type: PieceDefinitions.TYPES.duchess
  x:2
  y:2

