module Main where

convertToInt :: [String] -> [Int]
convertToInt = map read

fuel :: Integral a => a -> a
fuel m
  | f <= 0 = 0
  | otherwise = f 
  where f = quot m 3 - 2

fuel' :: Integral a => a -> a
fuel' 0 = 0
fuel' m = f + fuel' f
  where f = fuel m


part1 :: [Int] -> Int
part1 = sum . map fuel

part2 :: [Int] -> Int
part2 = sum . map fuel'


main :: IO ()
main = do
  file <- readFile "Day1.txt"
  let inputs = convertToInt $ lines file
  putStrLn $ "Part 1: " ++ (show $ part1 inputs)
  putStrLn $ "Part 2: " ++ (show $ part2 inputs)