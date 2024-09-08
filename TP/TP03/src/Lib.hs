-- | Módulo que implementa funciones utilizando recursividad de cola
module Lib
  ( -- * Identificación del práctico
    name,

    -- * Funciones recursivas
    --
    -- | Todas las funciones siguientes deben ser implementadas utilizando
    -- recursividad de cola.
    factorial,
    fibo,
    length',
    maximum',
    minimum',
    pow,
    product',
    reverse',
    sum',
    sumcubes,
    sumpowers,
    sumrange,
    sumsquares,
  )
where

-- | 'name' identifica al trabajo práctico
name :: String
name = "TP03"

-- Implemente todas las funciones usando recursividad de cola

-- | 'length'' devuelve la longitud de una lista finita como un entero (Int)
--
-- Ejemplos:
--
-- >>> length' "hola"
-- 4
-- >>> length' [1..10]
-- 10
-- >>> length' []
-- 0
length' :: [a] -> Int
length' xs = lengthAcum xs 0
  where
    lengthAcum [] n = n
    lengthAcum (_ : xs) n = lengthAcum xs (n + 1)

-- | 'sum'' calcula la suma de una lista finita de números
--
-- Ejemplos:
--
-- >>> sum' [1..1000]
-- 500500
-- >>> sum' [1000,999..1]
-- 500500
-- >>> sum' []
-- 0
sum' :: (Num a) => [a] -> a
sum' xs = sumAcum xs 0
  where
    sumAcum [] n = n
    sumAcum (x : xs) n = sumAcum xs (n + x)

-- | 'product'' calcula el producto de una lista finita de números
--
-- Ejemplos:
--
-- >>> product' [1..10]
-- 3628800
-- >>> product' [10,9..1]
-- 3628800
-- >>> product' []
-- 1
product' :: (Num a) => [a] -> a
product' xs = prodAcum xs 1
  where
    prodAcum [] n = n
    prodAcum (x : xs) n = prodAcum xs (n * x)

-- | 'reverse'' toma una lista y la invierte
--
-- Ejemplos:
--
-- >>> reverse' "Hola"
-- "aloH"
-- >>> reverse' []
-- []
-- >>> reverse' [1..10]
-- [10,9,8,7,6,5,4,3,2,1]
-- >>> reverse' (reverse' [1..10])
-- [1,2,3,4,5,6,7,8,9,10]
reverse' :: [a] -> [a]
reverse' xs = reverseAcum xs []
  where
    reverseAcum [] ys = ys
    reverseAcum (x : xs) ys = reverseAcum xs (x : ys)

-- | 'maximum'' devuelve el máximo de una lista de elementos
--
-- Si la lista está vacía, produce el error "empty list"
--
-- Ejemplos:
--
-- >>> maximum' "Hola"
-- 'o'
-- >>> maximum' [1..10]
-- 10
-- >>> maximum' [1,3,5,0,9,7,4,2,8,6]
-- 9
-- >>> maximum' [-1,-3,0,-5]
-- 0
-- >>> maximum' []
-- *** Exception: empty list
-- ...
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "empty list"
maximum' (x:xs) = maximumAcum xs x
  where
    maximumAcum [] n = n
    maximumAcum (x : xs) n = maximumAcum xs (max x n)

-- | 'minimum'' devuelve el minimo de una lista de elementos
--
-- Si la lista está vacía, produce el error "empty list"
--
-- Ejemplos:
--
-- >>> minimum' "Hola"
-- 'H'
-- >>> minimum' [1..10]
-- 1
-- >>> minimum' [1,3,5,0,9,7,4,2,8,6]
-- 0
-- >>> minimum' [-1,-3,0,-5]
-- -5
-- >>> minimum' []
-- *** Exception: empty list
-- ...
minimum' :: (Ord a) => [a] -> a
minimum' [] = error "empty list"
minimum' (x:xs) = minimumAcum xs x
  where
    minimumAcum [] n = n
    minimumAcum (x : xs) n = minimumAcum xs (min x n)

-- | 'factorial' calcula el factorial de un número entero (Integer)
--
-- Ejemplos:
--
-- >>> factorial 0
-- 1
-- >>> factorial 1
-- 1
-- >>> factorial 10
-- 3628800
-- >>> factorial 50
-- 30414093201713378043612608166064768844377641568960512000000000000
factorial :: Integer -> Integer
factorial n = factorialAcum n 1
  where
    factorialAcum 0 m = m
    factorialAcum n m = factorialAcum (n - 1) (n * m)

-- | 'fibo' calcula el enésimo número de Fibonacci F(n) donde F(n) = F(n-1) + F(n-2)
--
-- Ejemplos:
--
-- >>> fibo 0
-- 0
-- >>> fibo 1
-- 1
-- >>> fibo 10
-- 55
-- >>> fibo 42
-- 267914296
fibo :: Integer -> Integer
fibo n = fiboAcum n 0 1
  where
    fiboAcum 0 a _ = a
    fiboAcum n a b = fiboAcum (n - 1) b (a + b)

-- | 'pow' x eleva un entero a una potencia entera
--
-- Ejemplos:
--
-- >>> pow 12 2
-- 144
-- >>> pow 2 10
-- 1024
-- >>> pow 3 0
-- 1
pow :: (Integral a) => a -> a -> a
pow x n = powAcum x n 1
  where
    powAcum _ 0 m = m
    powAcum x n m = powAcum x (n - 1) (x * m)

-- | 'sumrange' calcula la suma de números contenidos en un rango,
-- ambos extremos incluídos.
--
-- Ejemplos
--
-- >>> sumrange 0 10
-- 55
-- >>> sumrange 3 5
-- 12
-- >>> sumrange 3 3
-- 3
-- >>> sumrange 5 2
-- 0
sumrange :: (Ord a, Integral a) => a -> a -> a
sumrange a b = sumrangeAcum a b 0
  where
    sumrangeAcum a b n
      | a > b = n
      | otherwise = sumrangeAcum (a + 1) b (n + a)

-- | 'sumsquares' calcula la suma de los cuadrados de los números en un rango
--
-- Ejemplos:
--
-- >>> sumsquares 1 10
-- 385
-- >>> sumsquares 5 4
-- 0
sumsquares :: (Ord a, Integral a) => a -> a -> a
sumsquares a b = sumsquaresAcum a b 0
  where
    sumsquaresAcum a b n
      | a > b = n
      | otherwise = sumsquaresAcum (a + 1) b (n + a * a)

-- | 'sumpowers' calcula la suma de la enésima potencia de los números en un rango
--
-- Ejemplos:
--
-- >>> sumpowers 1 10 2
-- 385
-- >>> sumpowers 1 10 0
-- 10
-- >>> sumpowers 0 10 1
-- 55
sumpowers :: (Ord a, Integral a) => a -> a -> a -> a
sumpowers a b n = sumpowersAcum a b n 0
  where
    sumpowersAcum a b n m
      | a > b = m
      | otherwise = sumpowersAcum (a + 1) b n (m + pow a n)

-- | 'sumcubes' calcula la suma de los cubos de los números en un rango
--
-- Ejemplos:
--
-- >>> sumcubes 1 10
-- 3025
-- >>> sumcubes 0 0
-- 0
-- >>> sumcubes 3 4
-- 91
sumcubes :: (Ord a, Integral a) => a -> a -> a
sumcubes a b = sumcubesAcum a b 0
  where
    sumcubesAcum a b n
      | a > b = n
      | otherwise = sumcubesAcum (a + 1) b (n + a * a * a)
