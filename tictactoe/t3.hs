-- Tic Tac Toe implementation in Haskell.

module TicTacToe (
    newGame,
    isWin,
    main,
    move,
    nextPlayer
) where

import Control.Lens (set, ix)
import Data.List (transpose)
import Data.Maybe (catMaybes)
import Text.Read (readMaybe)

data Player = X | O
    deriving (Show, Read, Eq)

type Marking = Maybe Player
type Grid = [[Marking]]

data GameState = Won Player | Draw | Running
    deriving (Show, Read, Eq)

data Game = Game {
    grid :: Grid,
    gridLen :: Int,
    curTurn :: Player
} deriving Show


-- Basic Definitions

nextPlayer X = O
nextPlayer O = X

emptyGrid :: Int -> Grid
emptyGrid n = replicate n $ replicate n Nothing

showGrid :: Grid -> String
showGrid = unlines . map showRow
    where showRow = unwords . map showMarking
          showMarking (Nothing) = "_"
          showMarking (Just a) = show a

getWinSeqs :: Grid -> [[Marking]]
getWinSeqs grid =
    horizontal ++ vertical ++ [fDiag, bDiag]
    where
        horizontal = grid
        vertical = transpose grid
        fDiag = zipWith (!!) (reverse grid) [0..]
        bDiag = zipWith (!!) grid [0..]


newGame = Game {
    grid = emptyGrid 3,
    gridLen = 3,
    curTurn = X
}

isWin :: Grid -> GameState
isWin grid
    | isWin' X = Won X
    | isWin' O = Won O
    | isDraw = Draw
    | otherwise = Running
    where
        isWin' player = any (all (== Just player)) $ getWinSeqs grid
        isDraw = all (\ row -> all (/= Nothing) row) grid

move :: Int -> Int -> Game -> Maybe Game
move i j (Game grid gridLen player)
    | validCoord i j = case grid !! i !! j of
        Just _ -> Nothing
        Nothing -> Just Game {
            grid = set (ix i . ix j) (Just player) grid,
            gridLen = gridLen,
            curTurn = nextPlayer player
        }
    | otherwise = Nothing
    where validCoord i j = i >= 0 && j >= 0 && i < gridLen && j < gridLen

moves :: Game -> [Game]
moves game = catMaybes [move x y game | x <- is, y <- is]
    where n = gridLen game
          is = [0 .. n - 1]


-- main client

main :: IO ()
main = do
    putStrLn "Make a move by typing (i, j). i represents the row and j represents the column."
    let game = newGame
    putStrLn $ showGrid $ grid game
    startGame game

startGame :: Game -> IO ()
startGame game = do
    line <- getLine
    case readMaybe line :: Maybe (Int, Int) of
        Just (i, j) -> case move i j game of
            Just newGame -> case isWin $ grid newGame of
                Won a -> putStrLn $ "Player " ++ show a ++ " won!"
                Draw -> putStrLn "It's a draw!"
                Running -> do
                    putStrLn $ showGrid $ grid newGame
                    startGame newGame
            Nothing -> do
                putStrLn "Invalid move. Please input a valid move."
                startGame game
        Nothing -> do
            putStrLn "Invalid move. Please input a valid move."
            startGame game
