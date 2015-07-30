(function() {

// Returns an empty n x n array.
function emptyGrid(n) {
  var array = Array(n);
  for (var i = 0; i < n; ++i) {
    var subarray = Array(n);
    for (var j = 0; j < n; ++j) {
      subarray[j] = null;
    }
    array[i] = subarray;
  }
  return array;
}

// Given the current player, returns the next player.
function nextPlayer(player) {
  switch (player) {
    case 'X': return 'O';
    case 'O': return 'X';
  }
}

function TicTacToe() {
  this.grid = emptyGrid(3);
}

TicTacToe.prototype.grid = null;
TicTacToe.prototype.gridSize = 3;
TicTacToe.prototype.curPlayer = 'X';
TicTacToe.prototype.gameState = null;

// Make a move, given the coordinates.
TicTacToe.prototype.move = function(x, y) {

};

// Get a list of possible winning sequences.
TicTacToe.prototype.getWinSeqs = function() {

};

// Check if any player has won the game.
TicTacToe.prototype.isWin = function() {

};

// Check if the game ended without winners.
TicTacToe.prototype.isDraw = function() {

};

window.TicTacToe = TicTacToe;

}());
