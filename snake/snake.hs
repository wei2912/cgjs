-- Snake implementation in Haskell.

module Snake (
    newGame,
    step
) where

import Control.Arrow (&&&)
import Control.Lens (set, ix)
import Data.Foldable (toList)

data Marking = Empty | Food | Snake
    deriving (Show, Read, Eq)
type Grid = [[Marking]]

type Coord = (Int, Int)
data Direction = N | E | W | S
    deriving (Show, Read, Eq)

type Snake = [Coord]

data Game = Game {
    grid :: Grid,
    snake :: Snake
} deriving Show


defaultGridSize :: Int
defaultGridSize = 5

emptyGrid :: Int -> Grid
emptyGrid n = replicate n $ replicate n Empty

stepCoord :: Direction -> Coord -> Coord
stepCoord N = tuply (pred, id)
stepCoord E = tuply (id, succ)
stepCoord W = tuply (id, pred)
stepCoord S = tuply (succ, id)

setCoord :: Marking -> Coord -> Grid -> Grid
setCoord mark (i, j) grid = set (ix i . ix j) mark grid

validCoord :: Coord -> Bool
validCoord (i, j) = i > 0 && j > 0 && i < defaultGridSize && j < defaultGridSize


newSnake :: Int -> Snake
newSnake n = [(mid, j) | j <- [mid .. mid + 2]]
    where mid = n `div` 2

stepSnake :: Snake -> Direction -> Maybe (Coord, Snake, Coord)
stepSnake snake dir
    | validCoord newHead && not (newHead `elem` snake) = Just (oldTail, newSnake, newHead)
    | otherwise = Nothing
    where oldTail = head snake
          body = tail snake
          oldHead = last snake
          newHead = stepCoord dir oldHead
          newSnake = body ++ [newHead]

newGame :: Game 
newGame = Game {
    grid = foldl (flip $ setCoord Snake) (emptyGrid defaultGridSize) (toList snake),
    snake = snake
} where snake = newSnake defaultGridSize

step :: Game -> Direction -> Maybe Game
step (Game grid snake) dir = case stepSnake snake dir of
    Nothing -> Nothing
    Just (oldTail, snake, newHead) -> Just $ Game (foldl f grid [(oldTail, Empty), (newHead, Snake)]) snake
    where f grid (coord, mark) = setCoord mark coord grid
