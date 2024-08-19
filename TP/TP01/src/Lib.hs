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
max' a b = error "No implementado"

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
max3 a b c = error "No implementado"

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
sum2 a b c = error "No implementado"

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
factorial n = error "No implementado"

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
fibo n = error "No implementado"

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
square x = error "No implementado"

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
pow x n = error "No implementado"

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
sumrange a b = error "No implementado"

-- | 'sumsquares' calcula la suma de los cuadrados de los números en un rango
--
-- Ejemplos:
--
-- >>> sumsquares 1 10
-- 385
-- >>> sumsquares 5 4
-- 0
sumsquares :: (Ord a, Integral a) => a -> a -> a
sumsquares a b = error "No implementado"

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
sumpowers a b n = error "No implementado"

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
sumcubes a b = error "No implementado"

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
quadraticroots a b c = error "No implementado"

-- | 'not'' implementa la función lógica "no"
--
-- Ejemplos:
--
-- >>> not' (3 > 4)
-- True
-- >>> not' True
-- False
not' :: Bool -> Bool
not' b = error "No implementado"

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
or' a b = error "No implementado"

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
xor' a b = error "No implementado"

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
and' a b = error "No implementado"
