


angular.module('prince', [] )

  .constant 'cfg',
    title: 'The Prince'
    cellCount: 6

  .controller 'MainController', ($scope, gameBoard, Piece, PieceDefinitions) ->
    $scope.definitions = PieceDefinitions
    $scope.newPiece = $scope.definitions.bowman
    
    $scope.addPiece = ->
      console.log "addPiece"
      gameBoard.pieces.push new Piece
        type: $scope.newPiece.type
        x:0
        y:0

    # Starting pieces
    gameBoard.pieces.push new Piece
      type: PieceDefinitions.TYPES.prince
      x:3
      y:5

    gameBoard.pieces.push new Piece
      type: PieceDefinitions.TYPES.footman
      x:2
      y:5
