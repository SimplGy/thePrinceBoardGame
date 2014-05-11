


angular.module('prince', [] )

  .constant 'cfg',
    title: 'The Prince'
    cellCount: 6

  .controller 'MainController', ($scope, gameBoard, Piece, PieceDefinitions) ->
    $scope.definitions = PieceDefinitions
    $scope.newPiece = $scope.definitions.bowman
    $scope.gameBoard = gameBoard

    $scope.addPiece = (ptype, px, py) ->
      gameBoard.pieces.push new Piece
        type: ptype
        x:px
        y:py

    # Starting pieces
    gameBoard.pieces.push new Piece
      type: PieceDefinitions.TYPES.prince
      x:3
      y:5

    gameBoard.pieces.push new Piece
      type: PieceDefinitions.TYPES.footman
      x:2
      y:5
