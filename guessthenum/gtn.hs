-- Guess The Number implementation in Haskell.

module GuessTheNum (
    newGame,
    genNum,
    checkNum
) where

-- Range of the numbers (inclusive to exclusive)
low = 1 :: Int
high = 100 :: Int

type Range = (Int, Int)
data Game = Game {
	num :: Int,
	range :: Range
} deriving Show

newGame = Game {
	
}
