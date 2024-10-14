package practico

/** Práctico 7 */
object Practico7:
  /** Este es el número de práctico */
  val practico = "7"

  /** Calcula la longitud de la lista xs
    *
    * Si bien puede resolverse mediante distintas técnicas, en este caso se
    * podrán utilizar los siguientes métodos de la clase `List`:
    *
    *   - `xs.isEmpty: Boolean` devuelve `true` si la lista `xs` está vacía
    *   - `xs.head: T` devuelve el primer elemento de la lista `xs`. Si la lista
    *     está vacía lanza una excepción.
    *   - `xs.tail: List[T]` devuelve la cola de la lista `xs`, esto es, la
    *     lista `xs` sin su primer elemento.
    *
    * @param xs
    *   Una lista
    * @return
    *   La longitud de la lista `xs`
    */
  def length[T](xs: List[T]): Int =
    if xs.isEmpty then 0
    else 1 + length(xs.tail)

  /** Calcula la suma de los elementos de una lista de enteros.
    *
    * Debe resolverse con las mismas herramientas que el método `length`
    *
    * @param xs
    *   Una lista de enteros
    * @return
    *   La suma de los enteros de la lista
    */
  def sum(xs: List[Int]): Int =
    if xs.isEmpty then 0
    else xs.head + sum(xs.tail)

  /** Devuelve el elemento más grande de una lista de enteros.
    *
    * Si la lista `xs` está vacía lanza la excepción `NoSuchElementException`.
    *
    * Es posible que sea necesario definir una función auxiliar.
    *
    * @param xs
    *   Una lista de enteros
    * @return
    *   El elemento más grande de `xs`
    * @throws NoSuchElementException
    *   , si `xs` es una lista vacía
    */
  def max(xs: List[Int]): Int =
    if xs.isEmpty then throw new NoSuchElementException("Lista vacía")
    else if xs.tail.isEmpty then xs.head
    else math.max(xs.head, max(xs.tail))

  /** Devuelve el factorial de un número.
    *
    * Si el número es negativo lanza la excepción IllegalArgumentException
    *
    * @param n
    *   es un entero
    * @return
    *   el factorial de `n`
    * @throws IllegalArgumentException
    *   , si el número es negativo.
    */
  def factorial(n: Int): BigInt =
    if n < 0 then throw new IllegalArgumentException("Número negativo")
    else if n == 0 then 1
    else n * factorial(n - 1)

  /** Devuelve el enésimo número de Fibonacci.
    *
    * Si el argumento es negativo lanza la excepción IllegalArgumentException
    *
    * - fibo(0) = 0
    * - fibo(1) = 1
    * - fibo(n) = fibo(n-1) + fibo(n-2)
    * 
    * @param n
    *   es un entero
    * @return
    *   el enésimo número de Fibonacci
    * @throws IllegalArgumentException
    *   , si el número es negativo.
    */
  def fibo(n: Int): BigInt =
    if n < 0 then throw new IllegalArgumentException("Número negativo")
    else if n == 0 then 0
    else if n == 1 then 1
    else fibo(n - 1) + fibo(n - 2)

  /** Calcula potencias enteras no negativas de enteros.
    *
    * @param x
    *   la base
    * @param n
    *   el exponente
    * @return
    *   x elevado a la n
    * @throws IllegalArgumentException
    *   , si el `n` es negativo
    */
  def pow(x: BigInt, n: Int): BigInt =
    if n < 0 then throw new IllegalArgumentException("Exponente negativo")
    else if n == 0 then 1
    else x * pow(x, n - 1)

  /** Calcula la suma de enteros contenidos en un rango.
    *
    * @param a
    *   el extremo inferior del rango
    * @param b
    *   el extremo superior del rango
    * @return
    *   la suma de los números contenidos en el rango [a,b]
    */
  def sumrange(a: BigInt, b: BigInt): BigInt =
    if a > b then 0
    else a + sumrange(a + 1, b)

  /** Calcula la suma de los cuadrados de los enteros de un rango.
    *
    * @param a
    *   el extremo inferior del rango
    * @param b
    *   el extremo superior del rango
    * @return
    *   la suma de cuadrados de los números en el rango [a,b]
    */
  def sumsquares(a: BigInt, b: BigInt): BigInt =
    if a > b then 0
    else a * a + sumsquares(a + 1, b)

  /** Calcula la suma de los cubos de los enteros de un rango.
    *
    * @param a
    *   el extremo inferior del rango
    * @param b
    *   el extremo superior del rango
    * @return
    *   la suma de cubos de los números en el rango [a,b]
    */
  def sumcubes(a: BigInt, b: BigInt): BigInt =
    if a > b then 0
    else a * a * a + sumcubes(a + 1, b)

  /** Calcula la suma de las potencias enésimas de los enteros de un rango.
    *
    * @param a
    *   el extremo inferior del rango
    * @param b
    *   el extremo superior del rango
    * @param n
    *   el exponente
    * @return
    *   la suma de las potencias enésimas de los números contenidos en el rango
    *   [a,b]
    * @throws IllegalArgumentException
    *   , si el `n` es negativo y el rango tiene al menos un elemento.
    */
  def sumpowers(a: BigInt, b: BigInt, n: Int): BigInt =
    if n < 0 && a <= b then throw new IllegalArgumentException("Exponente negativo y rango tiene elementos")
    else if a > b then 0
    else pow(a, n) + sumpowers(a + 1, b, n)

  /** Calcula las raíces de la ecuación de segundo grado ax^2 + bx + c.
    *
    * Devuelve un par de pares, cada uno de los cuales representa un número
    * complejo.
    *
    * @param a,b,c
    *   Los coeficientes
    * @return
    *   las raices de la ecuación
    * @throws IllegalArgumentException
    *   , si el coeficiente `a` es 0.
    */
  def quadraticRoots(a: Double, b: Double, c: Double): ((Double, Double), (Double, Double)) =
    if a == 0 then throw new IllegalArgumentException("El coeficiente 'a' no puede ser cero")
    else
      val discriminant = b * b - 4 * a * c
      if discriminant >= 0 then
        val root1 = (-b + math.sqrt(discriminant)) / (2 * a)
        val root2 = (-b - math.sqrt(discriminant)) / (2 * a)
        ((root1, 0.0), (root2, 0.0))
      else
        val realPart = -b / (2 * a)
        val imaginaryPart = math.sqrt(-discriminant) / (2 * a)
        ((realPart, imaginaryPart), (realPart, -imaginaryPart))

  /** Determina si los paréntesis en una cadena de caracteres estan balanceados.
    *
    * @param chars
    *   Una cadena de caracteres.
    * @return
    *   Verdadero si la cadena contiene paréntesis balanceados.
    */
  def balance(chars: String): Boolean =
    def loop(cs: List[Char], openCount: Int): Boolean =
      if cs.isEmpty then openCount == 0
      else if cs.head == '(' then loop(cs.tail, openCount + 1)
      else if cs.head == ')' then openCount > 0 && loop(cs.tail, openCount - 1)
      else loop(cs.tail, openCount)

    loop(chars.toList, 0)

  def main(args: Array[String]): Unit =
    println(s"Este es el práctico $practico\n")

end Practico7