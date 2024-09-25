-- | Este módulo consiste en la implementación de un tipo de dato @List@,
-- y de funciones que operan sobre ese tipo de dato
module Lib
  ( -- * Identificación del práctico
    name,

    -- * Tipos de datos
    List (..),
    Pair (..),

    -- * Funciones
    (+++),
    all',
    and',
    any',
    at,
    concat',
    cycle',
    drop',
    dropWhile',
    elem',
    filter',
    find',
    foldl',
    foldl1',
    foldr',
    foldr1',
    fst',
    head',
    init',
    iterate',
    last',
    length',
    lookup',
    map',
    maximum',
    minimum',
    notElem',
    null',
    or',
    partition',
    product',
    repeat',
    replicate',
    reverse',
    snd',
    span',
    sum',
    tail',
    take',
    takeWhile',
    unzip',
    zip',
    zipWith',
  )
where

-- | 'name' identifica al trabajo práctico
name :: String
name = "TP06"

-- | El tipo de dato 'List' es equivalente a una lista
infixr 5 :::

data List a = Empty | a ::: List a deriving (Eq, Ord)

-- | La función 'show' debe definirse de tal forma que la representación
-- textual de la lista consista en los elementos de la lista, separados
-- por comas y rodeados por corchetes.
--
-- Ejemplos:
--
-- >>> show (1 ::: 2 ::: 3 ::: Empty)
-- "[1,2,3]"
-- >>> show Empty
-- "[]"
instance (Show a) => Show (List a) where
  show Empty = "[]"
  show (x ::: xs) = "[" ++ showElements (x ::: xs) ++ "]"
    where
      showElements Empty = ""
      showElements (y ::: Empty) = show y
      showElements (y ::: ys) = show y ++ "," ++ showElements ys

-- | El tipo de dato 'Pair' representa un par de datos de tipos arbitrarios
data Pair a b = Pair a b deriving (Eq, Ord)

-- | La función 'show' debe devolver una String con la representación de los dos
-- elementos del par, separados por una coma y encerrados entre paréntesis.
--
-- Ejemplos:
--
-- >>> show (Pair True 3)
-- "(True,3)"
-- >>> show (Pair 'a' 4.4)
-- "('a',4.4)"
instance (Show a, Show b) => Show (Pair a b) where
  show (Pair x y) = "(" ++ show x ++ "," ++ show y ++ ")"

-- | 'foldr'' aplicado a un operador binario, un valor inicial y una lista,
-- reduce la lista aplicando el operador de derecha a izquierda.
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> foldr' (+) 0 l
-- 10
-- >>> foldr' (:) [] l
-- [1,2,3,4]
-- >>> foldr' (*) 1 Empty
-- 1
foldr' :: (a -> b -> b) -> b -> List a -> b
foldr' _ z Empty = z
foldr' f z (x ::: xs) = f x (foldr' f z xs)

-- | 'foldl'' aplicado a un operador binario, un valor inicial y una lista,
-- reduce la lista aplicando el operador de izquierda a derecha.
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> foldl' (flip (:)) [] l
-- [4,3,2,1]
-- >>> foldl' (+) 0 l
-- 10
-- >>> foldl' (*) 1 Empty
-- 1
foldl' :: (a -> b -> a) -> a -> List b -> a
foldl' _ acc Empty = acc
foldl' f acc (x ::: xs) = foldl' f (f acc x) xs

-- | 'foldr1'' es una variante de foldr' que no toma un valor inicial
-- y por lo tanto no puede aplicarse sobre listas vacías.
-- Si la lista está vacía produce un error con el mensaje "empty list"
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> foldr1' min l
-- 1
-- >>> foldr1' max l
-- 4
-- >>> foldr1' max Empty
-- *** Exception: empty list
-- ...
foldr1' :: (a -> a -> a) -> List a -> a
foldr1' _ Empty = error "empty list"
foldr1' _ (x ::: Empty) = x
foldr1' f (x ::: xs) = f x (foldr1' f xs)

-- | 'foldl1'' es una variante de foldl' que no toma un valor inicial
-- y por lo tanto no puede aplicarse sobre listas vacías.
-- Si la lista está vacía produce un error con el mensaje "empty list"
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> foldl1' min l
-- 1
-- >>> foldl1' max l
-- 4
-- >>> foldl1' max Empty
-- *** Exception: empty list
-- ...
foldl1' :: (a -> a -> a) -> List a -> a
foldl1' _ Empty = error "empty list"
foldl1' f (x ::: xs) = foldl' f x xs

-- | 'length'' devuelve la longitud de una lista finita como un entero (Int)
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> length' l
-- 4
-- >>> length' Empty
-- 0
length' :: List a -> Int
length' = foldl' (\acc _ -> acc + 1) 0

-- | 'head'' devuelve el primer elemento de una lista, que no puede ser vacia
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> head' l
-- 1
-- >>> head' Empty
-- ... empty list
-- ...
head' :: List a -> a
head' Empty = error "empty list"
head' (x ::: _) = x

-- | 'tail'' devuelve todos los elementos de una lista no vacia excepto el
-- primero
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> tail' l
-- [2,3,4]
-- >>> tail' Empty
-- ... empty list
-- ...
tail' :: List a -> List a
tail' Empty = error "empty list"
tail' (_ ::: xs) = xs

-- | 'last'' toma una lista y devuelve su último elemento
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> last' l
-- 4
-- >>> last' Empty
-- *** Exception: empty list
-- ...
last' :: List a -> a
last' Empty = error "empty list"
last' (x ::: Empty) = x
last' (_ ::: xs) = last' xs

-- | 'init'' toma una lista y devuelve todo excepto el último elemento
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> init' l
-- [1,2,3]
-- >>> init' Empty
-- ... empty list
-- ...
init' :: List a -> List a
init' Empty = error "empty list"
init' (_ ::: Empty) = Empty
init' (x ::: xs) = x ::: init' xs

-- | 'null'' devuelve verdadero si una lista está vacía y falso en caso
-- contrario
--
-- Ejemplos:
--
-- >>> null' (1 ::: Empty)
-- False
-- >>> null' Empty
-- True
null' :: List a -> Bool
null' Empty = True
null' _ = False

-- | (+++) concatena dos listas
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> l +++ l
-- [1,2,3,4,1,2,3,4]
-- >>> l +++ Empty
-- [1,2,3,4]
-- >>> Empty +++ l
-- [1,2,3,4]
-- >>> Empty +++ Empty
-- []
(+++) :: List a -> List a -> List a
Empty +++ ys = ys
(x ::: xs) +++ ys = x ::: (xs +++ ys)

-- | 'at' xs n devuelve el enésimo elemento de la lista (se comporta como !!)
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: 4 ::: Empty
-- >>> at l 1
-- 2
-- >>> l `at` 2
-- 3
-- >>> l `at` (-1)
-- *** Exception: negative index
-- ...
-- >>> l `at` 6
-- *** Exception: index too large
-- ...
at :: List a -> Int -> a
at _ n | n < 0 = error "negative index"
at Empty _ = error "index too large"
at (x ::: _) 0 = x
at (_ ::: xs) n = at xs (n - 1)

-- | 'take'' n xs devuelve una lista con los primeros n elementos de xs
--
-- Ejemplos:
--
-- >>> let l = foldr (:::) Empty [1..]
-- >>> take' 10 l
-- [1,2,3,4,5,6,7,8,9,10]
-- >>> take' 10 (take' 5 l)
-- [1,2,3,4,5]
-- >>> take' 0 l
-- []
-- >>> take' 10 Empty
-- []
take' :: Int -> List a -> List a
take' n _ | n <= 0 = Empty
take' _ Empty = Empty
take' n (x ::: xs) = x ::: take' (n - 1) xs

-- | 'drop'' n xs devuelve una lista en la que se han descartado los primeros
-- n elementos de xs
--
-- Ejemplos:
--
-- >>> let l = foldr (:::) Empty [1..10]
-- >>> drop' 5 l
-- [6,7,8,9,10]
-- >>> drop' 0 l
-- [1,2,3,4,5,6,7,8,9,10]
-- >>> drop' 15 l
-- []
-- >>> drop' 4 Empty
-- []
drop' :: Int -> List a -> List a
drop' n xs | n <= 0 = xs
drop' _ Empty = Empty
drop' n (_ ::: xs) = drop' (n - 1) xs

-- | 'sum'' calcula la suma de una lista finita de números
--
-- Ejemplos:
--
-- >>> let l = foldr (:::) Empty [1..100]
-- >>> sum' l
-- 5050
-- >>> sum' Empty
-- 0
sum' :: (Num a) => List a -> a
sum' = foldl' (+) 0

-- | 'product'' calcula el producto de una lista finita de números
--
-- Ejemplos:
--
-- >>> let l = foldr (:::) Empty [1..10]
-- >>> product' l
-- 3628800
-- >>> product' Empty
-- 1
product' :: (Num a) => List a -> a
product' = foldl' (*) 1

-- | 'reverse'' toma una lista y la invierte
--
-- Ejemplos:
--
-- >>> let l = foldr (:::) Empty [1..10]
-- >>> reverse' l
-- [10,9,8,7,6,5,4,3,2,1]
-- >>> reverse' (reverse' l)
-- [1,2,3,4,5,6,7,8,9,10]
reverse' :: List a -> List a
reverse' = foldl' (flip (:::)) Empty

-- | 'maximum'' devuelve el máximo de una lista de elementos
-- Si la lista está vacía produce un error con el mensaje "empty list"
--
-- Ejemplos:
--
-- >>> let l = foldr (:::) Empty [1..10]
-- >>> maximum' l
-- 10
-- >>> maximum' Empty
-- ... empty list
-- ...
--
-- prop> \x -> maximum' (x ::: Empty) == x
-- +++ OK, passed 100 tests.
maximum' :: (Ord a) => List a -> a
maximum' Empty = error "empty list"
maximum' (x ::: xs) = foldr1' max (x ::: xs)

-- | 'minimum'' devuelve el mínimo de una lista de elementos
-- Si la lista está vacía produce un error con el mensaje "empty list"
--
-- Ejemplos:
--
-- >>> let l = foldr (:::) Empty ['a'..'z']
-- >>> minimum' l
-- 'a'
-- >>> minimum' Empty
-- ... empty list
-- ...
--
-- prop> \x -> minimum' (x ::: Empty) == x
-- +++ OK, passed 100 tests.
minimum' :: (Ord a) => List a -> a
minimum' Empty = error "empty list"
minimum' (x ::: xs) = foldr1' min (x ::: xs)

-- | 'repeat'' toma un elemento y devuelve una lista infinita de ese elemento.
--
-- Ejemplos:
--
-- >>> take' 10 (repeat' 'x')
-- ['x','x','x','x','x','x','x','x','x','x']
-- >>> repeat' 9 `at` 1000
-- 9
repeat' :: a -> List a
repeat' x = x ::: repeat' x

-- | 'cycle'' toma una lista no vacía y la reproduce infinitamente.
--
-- Ejemplos:
--
-- >>> let l = 1 ::: 2 ::: 3 ::: Empty
-- >>> take' 7 (cycle' l)
-- [1,2,3,1,2,3,1]
cycle' :: List a -> List a
cycle' Empty = error "empty list"
cycle' xs = xs +++ cycle' xs

-- | 'replicate' n x devuelve una lista con n copias de x.
--
-- Ejemplos:
--
-- >>> replicate' 10 'x'
-- ['x','x','x','x','x','x','x','x','x','x']
-- >>> replicate' 5 (1 ::: Empty)
-- [[1],[1],[1],[1],[1]]
replicate' :: Int -> a -> List a
replicate' n x
  | n <= 0    = Empty
  | otherwise = x ::: replicate' (n - 1) x

-- | 'map'' toma una función y una lista y aplica esa función a cada elemento
-- de la lista.
--
-- Devuelve una nueva lista.
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..10]
-- >>> let letters = foldr (:::) Empty ['a'..'j']
-- >>> map' (\x -> x*x) numbers
-- [1,4,9,16,25,36,49,64,81,100]
-- >>> map' succ letters
-- ['b','c','d','e','f','g','h','i','j','k']
-- >>> map' succ Empty
-- []
map' :: (a -> b) -> List a -> List b
map' _ Empty = Empty
map' f (x ::: xs) = f x ::: map' f xs

-- | 'filter'' toma un predicado y una lista, y devuelve una nueva lista con
-- los elementos para los cuales se cumple el predicado.
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..10]
-- >>> let letters = foldr (:::) Empty ['a'..'j']
-- >>> filter' odd numbers
-- [1,3,5,7,9]
-- >>> filter' (>'c') letters
-- ['d','e','f','g','h','i','j']
-- >>> filter' (<0) numbers
-- []
-- >>> filter' (\_ -> True) Empty
-- []
filter' :: (a -> Bool) -> List a -> List a
filter' _ Empty = Empty
filter' p (x ::: xs)
  | p x       = x ::: filter' p xs
  | otherwise = filter' p xs

-- | 'concat'' concatena una lista de listas
--
-- Ejemplos:
--
-- >>> let l1 = foldr (:::) Empty [1..3]
-- >>> let l2 = foldr (:::) Empty [4..6]
-- >>> let l3 = foldr (:::) Empty [7..10]
-- >>> let listOfLists = l1:::l2:::l3:::Empty
-- >>> listOfLists
-- [[1,2,3],[4,5,6],[7,8,9,10]]
-- >>> concat' listOfLists
-- [1,2,3,4,5,6,7,8,9,10]
concat' :: List (List a) -> List a
concat' Empty = Empty
concat' (xs ::: xss) = xs +++ concat' xss

-- | 'and'' devuelve la conjunción de una lista de booleanos.
-- Para que el resultado sea True, la lista debe ser finita.
-- Para que sea False, debe haber un valor False en una posición finita
-- de una lista finita o infinita.
--
-- Ejemplos:
--
-- >>> and' (replicate' 10 True)
-- True
-- >>> and' Empty
-- True
-- >>> and' (False:::Empty)
-- False
-- >>> and' (True:::True:::True:::False:::Empty)
-- False
and' :: List Bool -> Bool
and' = foldr' (&&) True

-- | 'or'' devuelve la disyunción de una lista de booleanos.
-- Para que el resultado sea False, la lista debe ser finita.
-- Para que sea True, debe haber un valor True en una posición finita
-- de una lista finita o infinita.
--
-- Ejemplos:
--
-- >>> or' (replicate' 10 False)
-- False
-- >>> or' Empty
-- False
-- >>> or' (map' (==1000) (foldr (:::) Empty [1..]))
-- True
or' :: List Bool -> Bool
or' = foldr' (||) False

-- | 'any'' toma un predicado y una lista y devuelve verdadero si el predicado
-- se cumple para algún elemento de la lista
--
-- Ejemplos:
--
-- >>> any' odd Empty
-- False
-- >>> let numbers = foldr (:::) Empty [1..]
-- >>> any' (==1000) numbers
-- True
-- >>> any' (==1000) (take' 100 numbers)
-- False
any' :: (a -> Bool) -> List a -> Bool
any' p = or' . map' p

-- | 'all'' toma un predicado y una lista y devuelve verdadero si el predicado
-- se cumple para todos los elementos de la lista
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..100]
-- >>> all' odd numbers
-- False
-- >>> all' (>0) numbers
-- True
-- >>> all' (>0) Empty
-- True
all' :: (a -> Bool) -> List a -> Bool
all' p = and' . map' p

-- | 'elem'' x xs devuelve verdadero si x está en xs y falso en caso contrario
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..100]
-- >>> elem' 5 numbers
-- True
-- >>> 10 `elem'` numbers
-- True
-- >>> 0 `elem'` numbers
-- False
-- >>> 0 `elem'` Empty
-- False
elem' :: (Eq a) => a -> List a -> Bool
elem' _ Empty = False
elem' y (x ::: xs) = x == y || elem' y xs

-- | 'notElem'' x xs devuelve falso si x está en xs y verdadero en caso contrario
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..100]
-- >>> notElem' 5 numbers
-- False
-- >>> 10 `notElem'` numbers
-- False
-- >>> 0 `notElem'` numbers
-- True
-- >>> 0 `notElem'` Empty
-- True
notElem' :: (Eq a) => a -> List a -> Bool
notElem' x = not . elem' x

-- | 'find'' recibe un predicado y una lista y devuelve el primer elemento de
-- la lista que cumple ese predicado, o Nothing en caso contrario
--
-- Ejemplos:
--
-- >>> find' (>10) (1:::2:::3:::5:::Empty)
-- Nothing
-- >>> find' (>1) (1:::2:::Empty)
-- Just 2
-- >>> find' even (1:::2:::3:::5:::Empty)
-- Just 2
-- >>> find' even Empty
-- Nothing
find' :: (a -> Bool) -> List a -> Maybe a
find' _ Empty = Nothing
find' p (x ::: xs)
  | p x       = Just x
  | otherwise = find' p xs

-- | 'fst'' devuelve el primer elemento de un par
--
-- Ejemplos:
--
-- >>> fst' (Pair 3 4)
-- 3
-- >>> fst' (Pair True 'a')
-- True
-- >>> fst' (Pair Empty Nothing)
-- []
fst' :: Pair a b -> a
fst' (Pair x _) = x

-- | 'snd'' devuelve el segundo elemento de un par
--
-- Ejemplos:
--
-- >>> snd' (Pair 3 4)
-- 4
-- >>> snd' (Pair True 'a')
-- 'a'
-- >>> snd' (Pair Empty Nothing)
-- Nothing
snd' :: Pair a b -> b
snd' (Pair _ y) = y

-- | 'zip'' recibe dos listas y devuelve una lista de pares
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..6]
-- >>> let letters = foldr (:::) Empty ['a'..'z']
-- >>> zip' numbers letters
-- [(1,'a'),(2,'b'),(3,'c'),(4,'d'),(5,'e'),(6,'f')]
-- >>> zip' numbers Empty
-- []
-- >>> zip' Empty Empty
-- []
zip' :: List a -> List b -> List (Pair a b)
zip' Empty _ = Empty
zip' _ Empty = Empty
zip' (x ::: xs) (y ::: ys) = Pair x y ::: zip' xs ys

-- | 'unzip'' recibe una lista de pares y devuelve un par de listas
--
-- Ejemplos:
--
-- >>> let pairs = foldr (:::) Empty (map (\x -> Pair x (odd x)) [1..5])
-- >>> pairs
-- [(1,True),(2,False),(3,True),(4,False),(5,True)]
-- >>> unzip' pairs
-- ([1,2,3,4,5],[True,False,True,False,True])
-- >>> let numbers = foldr (:::) Empty [1..6]
-- >>> let letters = foldr (:::) Empty ['a'..'f']
-- >>> unzip' (zip' numbers letters) == Pair numbers letters
-- True
unzip' :: List (Pair a b) -> Pair (List a) (List b)
unzip' Empty = Pair Empty Empty
unzip' (Pair x y ::: ps) = Pair (x ::: xs) (y ::: ys)
  where
    Pair xs ys = unzip' ps

-- | 'lookup'' busca una clave entre los primeros elementos de una lista de
-- pares y devuelve el segundo elemento encerrado en un Just, o Nothing si
-- no lo encuentra.
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..]
-- >>> let letters = foldr (:::) Empty ['a'..'z']
-- >>> let pairs = zip' letters numbers
-- >>> take' 9 pairs
-- [('a',1),('b',2),('c',3),('d',4),('e',5),('f',6),('g',7),('h',8),('i',9)]
-- >>> lookup' 'c' pairs
-- Just 3
-- >>> lookup' 'z' pairs
-- Just 26
-- >>> lookup' 'C' pairs
-- Nothing
-- >>> lookup' 'c' Empty
-- Nothing
lookup' :: (Eq k) => k -> List (Pair k v) -> Maybe v
lookup' _ Empty = Nothing
lookup' k (Pair x y ::: xs)
  | k == x    = Just y
  | otherwise = lookup' k xs

-- | 'zipWith'' toma una función que acepta dos parámetros, y dos listas
-- y devuelve una nueva lista que resulta unir las otras dos mediante la función
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..10]
-- >>> let twos = replicate' 10 2
-- >>> zipWith' (*) numbers (tail' numbers)
-- [2,6,12,20,30,42,56,72,90]
-- >>> zipWith' (**) numbers twos
-- [1.0,4.0,9.0,16.0,25.0,36.0,49.0,64.0,81.0,100.0]
-- >>> zipWith' (-) numbers numbers
-- [0,0,0,0,0,0,0,0,0,0]
-- >>> zipWith' (+) numbers Empty
-- []
-- >>> zipWith' (*) Empty Empty
-- []
zipWith' :: (a -> b -> c) -> List a -> List b -> List c
zipWith' _ Empty _ = Empty
zipWith' _ _ Empty = Empty
zipWith' f (x ::: xs) (y ::: ys) = f x y ::: zipWith' f xs ys

-- | 'takeWhile'' toma un predicado y una función y devuelve el prefijo más
-- largo de la lista para el cual se verifica el predicado
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..]
-- >>> let letters = foldr (:::) Empty ['a'..'z']
-- >>> takeWhile' (/=7) numbers
-- [1,2,3,4,5,6]
-- >>> takeWhile' (\x -> notElem x "frog") letters
-- ['a','b','c','d','e']
-- >>> takeWhile' odd numbers
-- [1]
-- >>> takeWhile' even numbers
-- []
-- >>> takeWhile' odd Empty
-- []
takeWhile' :: (a -> Bool) -> List a -> List a
takeWhile' _ Empty = Empty
takeWhile' p (x ::: xs)
  | p x       = x ::: takeWhile' p xs
  | otherwise = Empty

-- | 'dropWhile'' toma un predicado y una función y descarta el prefijo más
-- largo de la lista para el cual se verifica el predicado
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..10]
-- >>> let letters = foldr (:::) Empty ['a'..'z']
-- >>> dropWhile' (/=7) numbers
-- [7,8,9,10]
-- >>> dropWhile' (\x -> notElem x "stop") letters
-- ['o','p','q','r','s','t','u','v','w','x','y','z']
-- >>> dropWhile' odd numbers
-- [2,3,4,5,6,7,8,9,10]
-- >>> dropWhile' even numbers
-- [1,2,3,4,5,6,7,8,9,10]
-- >>> dropWhile' odd Empty
-- []
dropWhile' :: (a -> Bool) -> List a -> List a
dropWhile' _ Empty = Empty
dropWhile' p (x ::: xs)
  | p x       = dropWhile' p xs
  | otherwise = x ::: xs

-- | 'span'', toma un predicado p y una lista xs, y devuelve una tupla en la que
-- el primer elemento contiene los primeros elementos de xs que satisfacen p,
-- y el segundo elemento contiene el resto de la lista
-- span' p xs es equivalente a Pair (takeWhile' p xs) (dropWhile' p xs)
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..10]
-- >>> span' (/=7) numbers
-- ([1,2,3,4,5,6],[7,8,9,10])
-- >>> span' (==7) numbers
-- ([],[1,2,3,4,5,6,7,8,9,10])
-- >>> span' odd numbers
-- ([1],[2,3,4,5,6,7,8,9,10])
-- >>> span' even numbers
-- ([],[1,2,3,4,5,6,7,8,9,10])
-- >>> span' odd Empty
-- ([],[])
span' :: (a -> Bool) -> List a -> Pair (List a) (List a)
span' p xs = Pair (takeWhile' p xs) (dropWhile' p xs)

-- | 'partition'' toma un predicado y una lista y devuelve un par de listas
-- la primera de los cuales contiene los elementos que satisfacen el predicado
-- y la segunda los que no lo satisfacen.
-- partition' p xs == Pair (filter' p xs)  (filter' (not . p) xs)
--
-- Ejemplos:
--
-- >>> let numbers = foldr (:::) Empty [1..10]
-- >>> partition' (/=7) numbers
-- ([1,2,3,4,5,6,8,9,10],[7])
-- >>> partition' (==7) numbers
-- ([7],[1,2,3,4,5,6,8,9,10])
-- >>> partition' odd numbers
-- ([1,3,5,7,9],[2,4,6,8,10])
-- >>> partition' even numbers
-- ([2,4,6,8,10],[1,3,5,7,9])
-- >>> partition' odd Empty
-- ([],[])
partition' :: (a -> Bool) -> List a -> Pair (List a) (List a)
partition' p xs = Pair (filter' p xs) (filter' (not . p) xs)

-- | 'iterate'' toma una función y un valor inicial, y devuelve una lista
-- infinita que resulta de la aplicación repetida de la función sobre el valor -- inicial
--
-- Ejemplos:
--
-- >>> take' 10 (iterate' (*2) 1)
-- [1,2,4,8,16,32,64,128,256,512]
-- >>> take' 5 (iterate' (\x -> x*x) 2)
-- [2,4,16,256,65536]
-- >>> take' 5 (iterate' (\x -> succ(head' x):::x) ('a':::Empty))
-- [['a'],['b','a'],['c','b','a'],['d','c','b','a'],['e','d','c','b','a']]
iterate' :: (a -> a) -> a -> List a
iterate' f x = x ::: iterate' f (f x)