-- Tic Tac Toe implementation in Haskell.

module TicTacToe (
    newGame,
    isWin,
    move
) where

import Control.Lens
import Data.List
import Data.Maybe

-- Size of the grid
n :: Int
n = 3

data Player = X | O deriving (Show, Read, Eq)
type Marking = Maybe Player
type Position = (Int, Int)

type Grid = [[Marking]]

-- An empty grid of size n x n.
emptyGrid :: Grid
emptyGrid = replicate n $ replicate n Nothing

data Game = Game {
    board :: Grid,
    curTurn :: Player
} deriving Show

-- Initial game which board is of size n x n,
-- starting with O as the first player.
newGame :: Game
newGame = Game {
    board = emptyGrid,
    curTurn = X
}

getWinSeqs :: Grid -> [[Marking]]
getWinSeqs grid = horizontal ++ vertical ++ [fDiag, bDiag]
  where horizontal = grid
        vertical = transpose grid
        fDiag = zipWith (\ i x -> i !! (n - x - 1)) grid [0..]
        bDiag = zipWith (!!) grid [0..]

-- Check if a game has been won on a board.
isWin :: Game -> Maybe Player
isWin (Game grid _)
    | isWin' X  = Just X
    | isWin' O  = Just O
    | otherwise = Nothing
    where
        isWin' :: Player -> Bool
        isWin' player = any (all (== Just player)) $ getWinSeqs grid

-- Make the next move.
move :: Game -> Position -> Game
move (Game grid player) (i, j) = Game {
    board = nextGrid,
    curTurn = nextPlayer
} where
    nextGrid =
        if isNothing $ grid !! i !! j
        then set (ix i . ix j) (Just player) grid
        else error "position is occupied"
    nextPlayer
        | player == X = O
        | otherwise   = X
