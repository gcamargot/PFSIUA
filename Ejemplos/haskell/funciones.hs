-- Calcula el cuadrado de un número
cuadrado :: Int -> Int
cuadrado x = x * x

sumar a b = a + b

abs' n = if n < 0 then negate n else n

factorial :: Integral a => a -> a
factorial n = if n == 0 then 1 else n * factorial (n-1)

