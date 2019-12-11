-- | Advent of Code 2019 Day p

module Main where

import Data.List (groupBy)
  
type Digits = [Int]
  
toDigits :: Int -> Digits
toDigits 0 = []
toDigits x = toDigits (x `div` 10) ++ [x `mod` 10]

isIncreasing :: Digits -> Bool
isIncreasing (x:y:[]) = y >= x
isIncreasing (x:y:ys) | y >= x = isIncreasing (y:ys)
                      | otherwise = False

hasDouble :: Digits -> Bool
hasDouble (x:y:[]) = x == y
hasDouble (x:y:ys) | x == y = True
                   | otherwise = hasDouble (y:ys)
                     
isValid :: Digits -> Bool
isValid d = (hasDouble d) && (isIncreasing d)
 
inputs :: [Digits] 
inputs = map toDigits [146810 .. 612564]

validPasswords = filter isValid inputs

hasDouble' :: Digits -> Bool
hasDouble' d = 2 `elem` grouped
  where grouped = map length $ groupBy (==) d

isValid' :: Digits -> Bool
isValid' d = (hasDouble' d) && (isIncreasing d)
  
validPasswords' :: [Digits]
validPasswords' = filter isValid' validPasswords

part1 :: String
part1 = show $ length $ validPasswords

part2 :: String
part2 = show $ length $ validPasswords'

main :: IO ()
main =
  putStrLn $ "Part1: " ++ part1 ++ "\n" ++ "Part2: " ++ part2

