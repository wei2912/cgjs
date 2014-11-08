-- Tic Tac Toe implementation in Haskell.

module TicTacToe (
    newGame,
    isWin,
    move,
    moves,
    nextPlayer
) where

import Control.Lens (set, ix)
import Data.List (transpose)
import Data.Maybe (catMaybes)

-- Size of the grid
n :: Int
n = 3

data Player = X | O deriving (Show, Read, Eq)
type Marking = Maybe Player

type Grid = [[Marking]]

emptyGrid :: Grid
emptyGrid = replicate n $ replicate n Nothing

data Game = Game {
    board :: Grid,
    curTurn :: Player
} deriving Show

newGame :: Game
newGame = Game {
    board = emptyGrid,
    curTurn = X
}


getWinSeqs :: Grid -> [[Marking]]
getWinSeqs grid = horizontal ++ vertical ++ [fDiag, bDiag]
  where horizontal = grid
        vertical = transpose grid
        fDiag = zipWith (!!) (reverse grid) [0..]
        bDiag = zipWith (!!) grid [0..]

isWin :: Grid -> Maybe Player
isWin grid
    | isWin' X  = Just X
    | isWin' O  = Just O
    | otherwise = Nothing
    where
        isWin' :: Player -> Bool
        isWin' player = any (all (== Just player)) $ getWinSeqs grid

move :: Int -> Int -> Game -> Maybe Game
move i j (Game grid player) = case grid !! i !! j of
    Just _ -> Nothing
    Nothing -> Just Game {
        board = set (ix i . ix j) (Just player) grid,
        curTurn = nextPlayer player
    }

moves :: Game -> [Game]
moves game = catMaybes [move x y game | x <- [0..n - 1], y <- [0..n - 1]]

nextPlayer :: Player -> Player
nextPlayer X = O
nextPlayer O = X
