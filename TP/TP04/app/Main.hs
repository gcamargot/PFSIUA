module Main where

import Lib (name)

main :: IO ()
main = putStrLn ("Este es el " ++ name)
