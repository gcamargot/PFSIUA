-- | Módulo que contiene los ejercicios del práctico 1
module Lib
  ( -- * Identificación del pŕactico
    name,

    -- * Funciones
    and',
    factorial,
    fibo,
    max',
    max3,
    not',
    or',
    pow,
    quadraticroots,
    square,
    sum2,
    sumcubes,
    sumpowers,
    sumrange,
    sumsquares,
    xor',
  )
where

-- | 'name' identifica al trabajo práctico
name :: [Char]
name = "TP01"

-- | 'max'' devuelve el máximo entre dos elementos que poseen una relación de
-- orden
--
-- Ejemplos:
--
-- >>> max' 0 1
-- 1
-- >>> max' 1 0
-- 1
-- >>> max' (-1) (-3)
-- -1
max' :: (Ord a) => a -> a -> a
max' a b = if a < b then b else a

-- | 'max3' devuelve el valor máximo de tres elementos
--
-- Ejemplos:
--
-- >>> max3 1 2 3
-- 3
-- >>> max3 "ab" "ac" "aa"
-- "ac"
-- >>> max3 [1,2,3] [1,2] []
-- [1,2,3]
max3 :: (Ord a) => a -> a -> a -> a
max3 a b c = 
  if a < b then 
    max' b c 
  else max' a c

-- | 'sum2' recibe tres números y devuelve la suma de los dos mayores
--
-- Ejemplos:
--
-- >>> sum2 3 4 1
-- 7
-- >>> sum2 4 7 9
-- 16
-- >>> sum2 8 0 8
-- 16
sum2 :: (Ord a, Num a) => a -> a -> a -> a
sum2 a b c = 
    if a < b then 
      b + max' a c 
    else a + max' b c

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
factorial n = 
    if n == 0 then 1 
    else n * factorial (n - 1)

-- | 'fibo' calcula el enésimo número de Fibonacci \(F(n)\) donde
-- \(F(n) = F(n-1) + F(n-2)\)
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
fibo n
  | n == 0 = 0
  | n == 1 = 1
  | otherwise = fibo (n - 1) + fibo (n - 2)

-- | 'square' calcula el cuadrado de un número
--
-- Ejemplos:
--
-- >>> square 5
-- 25
-- >>> square 5.0
-- 25.0
-- >>> square 99
-- 9801
square :: (Num a) => a -> a
square x = x * x

-- | 'pow' x eleva un entero a una potencia entera. Si se invoca con un
-- exponente negativo produce el error @Negative exponent@
--
-- Ejemplos:
--
-- >>> pow 12 2
-- 144
-- >>> pow 2 10
-- 1024
-- >>> pow 3 0
-- 1
-- >>> pow 2 (-1)
-- *** Exception: Negative exponent
-- ...
pow :: (Integral a) => a -> a -> a
pow x n = 
    if n < 0 then error "Negative exponent" 
    else if n == 0 then 1 
    else
      x * pow x (n - 1)

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
sumrange a b = 
    if a > b then 0 
    else a + sumrange (a + 1) b

-- | 'sumsquares' calcula la suma de los cuadrados de los números en un rango
--
-- Ejemplos:
--
-- >>> sumsquares 1 10
-- 385
-- >>> sumsquares 5 4
-- 0
sumsquares :: (Ord a, Integral a) => a -> a -> a
sumsquares a b = 
    if a > b then 0 
    else square a + sumsquares (a + 1) b

-- | 'sumpowers' calcula la suma de la enésima potencia de los números en un
-- rango. Si el rango no está vacío, y el exponente es negativo, produce el
-- error @Negative exponent@
--
-- Ejemplos:
--
-- >>> sumpowers 1 10 2
-- 385
-- >>> sumpowers 1 10 0
-- 10
-- >>> sumpowers 0 10 1
-- 55
-- >>> sumpowers 1 0 5
-- 0
-- >>> sumpowers 1 5 (-1)
-- *** Exception: Negative exponent
-- ...
sumpowers :: (Ord a, Integral a) => a -> a -> a -> a
sumpowers a b n
  | n < 0 = error "Negative exponent"
  | a > b = 0
  | otherwise = pow a n + sumpowers (a + 1) b n

-- | 'sumcubes' calcula la suma de los cubos de los números en un rango.
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
sumcubes a b = 
    if a > b then 0 
    else pow a 3 + sumcubes (a + 1) b

-- | 'quadraticroots' calcula las raíces de la ecuación de segundo grado
-- \(ax^2 + bx + c = 0\)
--
-- Devuelve un par de pares, cada uno de los cuales representa un número
-- complejo. Si el coeficiente `a` es cero, produce el error @bad equation@.
--
-- Ejemplos:
--
-- >>> quadraticroots 1 4 3
-- ((-1.0,0.0),(-3.0,0.0))
-- >>> quadraticroots 1 4 5
-- ((-2.0,1.0),(-2.0,-1.0))
-- >>> quadraticroots 0 1 2
-- *** Exception: bad equation
-- ...
quadraticroots :: Double -> Double -> Double -> ((Double, Double), (Double, Double))
quadraticroots a b c =
    if a == 0 then
        error "bad equation"
    else
        let delta = b * b - 4 * a * c
            sqrtDelta = sqrt (abs delta)
            realPart = -b / (2 * a)
            imagPart = sqrtDelta / (2 * a)
        in if delta > 0 then
               let r1 = (realPart + imagPart)
                   r2 = (realPart - imagPart)
               in ((r1, 0.0), (r2, 0.0))
           else if delta == 0 then
               ((realPart, 0.0), (realPart, 0.0))
           else
               ((realPart, imagPart), (realPart, -imagPart))

-- | 'not'' implementa la función lógica "no"
--
-- Ejemplos:
--
-- >>> not' (3 > 4)
-- True
-- >>> not' True
-- False
not' :: Bool -> Bool
not' b =  
    if b then 
     False 
    else True

-- | 'or'' implementa la función lógica "o"
--
-- Debe implementarse sin usar las operaciones lógicas predefinidas
--
-- Ejemplos:
--
-- >>> True `or'` True
-- True
-- >>> True `or'` False
-- True
-- >>> False `or'` True
-- True
-- >>> False `or'` False
-- False
or' :: Bool -> Bool -> Bool
or' a b = 
    if a then 
      True 
    else b

-- | 'xor'' implementa la función lógica "o" exclusiva
--
-- Debe implementarse sin usar las operaciones lógicas predefinidas
--
-- Ejemplos:
--
-- >>> True `xor'` True
-- False
-- >>> True `xor'` False
-- True
-- >>> False `xor'` True
-- True
-- >>> False `xor'` False
-- False
xor' :: Bool -> Bool -> Bool
xor' a b = 
    if a == b then 
      False 
    else True

-- | 'and'' implementa la función lógica "y"
--
-- Debe implementarse sin usar las operaciones lógicas predefinidas
--
-- Ejemplos:
--
-- >>> True `and'` True
-- True
-- >>> True `and'` False
-- False
-- >>> False `and'` True
-- False
-- >>> False `and'` False
-- False
and' :: Bool -> Bool -> Bool
and' a b = 
    if a then b 
    else False
