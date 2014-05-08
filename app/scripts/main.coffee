


angular.module('prince', [] )

  .constant 'cfg',
    title: 'The Prince'
    cellCount: 6

  .controller 'MainController', (gameBoard, Piece, PieceDefinitions) ->
    # Starting pieces
    gameBoard.pieces.push new Piece
      type: PieceDefinitions.TYPES.prince
      x: 2
      y: 5
    gameBoard.pieces.push new Piece
      type: PieceDefinitions.TYPES.footman
      x: 2
      y: 4
    gameBoard.pieces.push new Piece
      type: PieceDefinitions.TYPES.footman
      x:3
      y:5

    gameBoard.pieces.push new Piece
      type: PieceDefinitions.TYPES.pikeman
      x:5
      y:0