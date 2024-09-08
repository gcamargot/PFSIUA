import Control.Exception (SomeException, catch, evaluate)
import Control.Monad (unless)
import Data.List (isInfixOf)
import Lib
  ( factorial,
    fibo,
    length',
    maximum',
    minimum',
    name,
    pow,
    product',
    reverse',
    sum',
    sumcubes,
    sumpowers,
    sumrange,
    sumsquares,
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
      [ testCase "name" (name @?= "TP03")
      ],
    testGroup
      "Lists"
      [ testProperty "length'" ((\xs -> length xs == length' xs) :: [Int] -> Bool),
        testProperty "int sum'" ((\xs -> sum xs == sum' xs) :: [Int] -> Bool),
        testProperty "int product'" ((\xs -> product xs == product' xs) :: [Int] -> Bool),
        testProperty "double sum'" ((\xs -> sum xs ~==? sum' xs) :: [Double] -> Result),
        testProperty "double product'" ((\xs -> product xs ~==? product' xs) :: [Double] -> Result),
        testCase "null length" (length' [] @?= 0),
        testCase "zero product" (product' [3.1, 2.3, 5.0, 0.0] @?= 0.0),
        testCase "double sum case" (assertApproxEqual "double sum" 1e-6 4.6 (sum' [1.2, 3.4])),
        testCase "double product case" (assertApproxEqual "double product" 1e-6 4.08 (product' [1.2, 3.4])),
        testProperty "reverse'" ((\xs -> reverse xs == reverse' xs) :: [Char] -> Bool),
        testProperty "maximum'" ((\xs -> xs /= [] ==> maximum xs == maximum' xs) :: [Int] -> Property),
        testProperty "minimum'" ((\xs -> xs /= [] ==> minimum xs == minimum' xs) :: [Int] -> Property),
        testCase "maximum' empty list" (assertRaises (maximum' [] :: [Int]) "empty list"),
        testCase "minimum' empty list" (assertRaises (minimum' [] :: [Int]) "empty list")
      ],
    testGroup
      "Numbers"
      [ testProperty "factorial" (\n -> n >= 0 ==> factorial n == product [1 .. n]),
        testCase "fibo" (map fibo [0 .. 15] @?= [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]),
        testProperty "pow" ((\x n -> n >= 0 ==> pow x n == x ^ n) :: Int -> Int -> Property),
        testProperty "sumrange" ((\a b -> sumrange a b == sum [a .. b]) :: Int -> Int -> Bool),
        testProperty "sumsquares" ((\a b -> sumsquares a b == sum (map (\x -> x * x) [a .. b])) :: Int -> Int -> Bool),
        testProperty "sumcubes" ((\a b -> sumcubes a b == sum (map (\x -> x * x * x) [a .. b])) :: Int -> Int -> Bool),
        testProperty "sumpowers" ((\a b n -> n >= 0 ==> sumpowers a b n == sum (map (^ n) [a .. b])) :: Int -> Int -> Int -> Property)
      ]
  ]
