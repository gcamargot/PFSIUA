import Control.Exception (SomeException, catch, evaluate)
import Control.Monad (unless)
import Data.List (isInfixOf)
import Lib
  ( at,
    cycle',
    drop',
    elem',
    fst',
    head',
    init',
    last',
    length',
    maximum',
    minimum',
    name,
    null',
    product',
    repeat',
    replicate',
    reverse',
    snd',
    sum',
    tail',
    take',
    unzip',
    zip',
    (+++),
  )
import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.HUnit (testCase)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.HUnit (assertFailure, (@?=))
import Test.HUnit.Approx (assertApproxEqual)
import Test.QuickCheck (Property, (==>))
import Test.QuickCheck.Assertions (Result, (~==?))

main :: IO ()
main = defaultMain tests

catchToBool :: a -> [Char] -> IO Bool
catchToBool assertion message =
  catch
    ( do
        evaluate assertion
        return False
    )
    ((\e -> return (message `isInfixOf` show e)) :: SomeException -> IO Bool)

assertRaises :: a -> [Char] -> IO ()
assertRaises assertion message = do
  x <- catchToBool assertion message
  unless x (assertFailure "Exception not thrown")

tests =
  [ testGroup
      "Name"
      [ testCase "name" (name @?= "TP02")
      ],
    testGroup
      "Lists"
      [ testProperty "head'" ((\xs -> xs /= [] ==> head xs == head' xs) :: [Int] -> Property),
        testProperty "tail'" ((\xs -> xs /= [] ==> tail xs == tail' xs) :: [Int] -> Property),
        testProperty "last'" ((\xs -> xs /= [] ==> last xs == last' xs) :: [Int] -> Property),
        testProperty "init'" ((\xs -> xs /= [] ==> init xs == init' xs) :: [Int] -> Property),
        testProperty "length'" ((\xs -> length xs == length' xs) :: [Int] -> Bool),
        testProperty "int sum'" ((\xs -> sum xs == sum' xs) :: [Int] -> Bool),
        testProperty "int product'" ((\xs -> product xs == product' xs) :: [Int] -> Bool),
        testProperty "double sum'" ((\xs -> sum xs ~==? sum' xs) :: [Double] -> Result),
        testProperty "double product'" ((\xs -> product xs ~==? product' xs) :: [Double] -> Result),
        testCase "null length" (length' [] @?= 0),
        testCase "zero product" (product' [3.1, 2.3, 5.0, 0.0] @?= 0.0),
        testCase "double sum case" (assertApproxEqual "double sum" 1e-6 4.6 (sum' [1.2, 3.4])),
        testCase "double product case" (assertApproxEqual "double product" 1e-6 4.08 (product' [1.2, 3.4])),
        testProperty "null'" ((\xs -> null xs == null' xs) :: [Int] -> Bool),
        testProperty "at chars" ((\n xs -> n >= 0 && n < length xs ==> xs !! n == at xs n) :: Int -> [Char] -> Property),
        testProperty "+++" ((\xs ys -> xs ++ ys == xs +++ ys) :: [Int] -> [Int] -> Bool),
        testProperty "elem' chars" ((\c xs -> elem c xs == elem' c xs) :: Char -> [Char] -> Bool),
        testProperty "take'" ((\n xs -> take n xs == take' n xs) :: Int -> [Int] -> Bool),
        testProperty "drop'" ((\n xs -> drop n xs == drop' n xs) :: Int -> [Int] -> Bool),
        testProperty "reverse'" ((\xs -> reverse xs == reverse' xs) :: [Char] -> Bool),
        testProperty "maximum'" ((\xs -> xs /= [] ==> maximum xs == maximum' xs) :: [Int] -> Property),
        testProperty "minimum'" ((\xs -> xs /= [] ==> minimum xs == minimum' xs) :: [Int] -> Property),
        testProperty "repeat'" ((\x -> replicate 25 x == take 25 (repeat' x)) :: Char -> Bool),
        testProperty "cycle'" ((\xs -> xs /= [] ==> take 25 (cycle xs) == take 25 (cycle' xs)) :: [Char] -> Property),
        testProperty "replicate'" ((\n x -> replicate n x == replicate' n x) :: Int -> Char -> Bool),
        testCase "head' of empty list" (assertRaises (head' []) "empty list"),
        testCase "tail' of empty list" (assertRaises (tail' []) "empty list"),
        testCase "last' of empty list" (assertRaises (last' []) "empty list"),
        testCase "init' of empty list" (assertRaises (init' []) "empty list"),
        testCase "at negative index" (assertRaises (at [True] (-1)) "negative index"),
        testCase "at empty list" (assertRaises (at [] 0) "index too large"),
        testCase "at index too large" (assertRaises (at [1, 2, 3] 3) "index too large"),
        testCase "maximum' empty list" (assertRaises (maximum' [] :: [Int]) "empty list"),
        testCase "minimum' empty list" (assertRaises (minimum' [] :: [Int]) "empty list"),
        testCase "cycle' empty list" (assertRaises (cycle' [] :: [Int]) "empty list")
      ],
    testGroup
      "Tuples"
      [ testProperty "fst'" ((\x y -> fst' (x, y) == x) :: Char -> Int -> Bool),
        testProperty "snd'" ((\x y -> snd' (x, y) == y) :: Char -> Int -> Bool),
        testProperty "zip'" ((\xs ys -> zip xs ys == zip' xs ys) :: [Int] -> [Char] -> Bool),
        testProperty "unzip'" ((\xys -> unzip xys == unzip' xys) :: [(Int, Char)] -> Bool)
      ]
  ]
