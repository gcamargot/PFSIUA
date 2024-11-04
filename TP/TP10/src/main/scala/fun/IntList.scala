package fun

/** Enum que implementa una lista enlazada inmutable de enteros.
  *
  * También se podría haber implementado con case classes
  *
  * Esta versión tiene una implementación funcional
  */
enum IntList:
  /** Representa una lista vacía */
  case Empty

  /** Representa una lista no vacía */
  case Cons(head: Int, tail: IntList)

  override def toString: String = IntList.mkString("IntList(", ",", ")")(this)
end IntList

/** Objeto que provee un conjunto de funciones sobre listas de enteros */
object IntList:

  /** Construye una IntList compuesta por los números en `args`
    *
    * @param args
    *   Una secuencia de enteros
    * @return
    *   Una instancia de IntList
    */
  def apply(args: Int*): IntList = {
    args.foldRight(empty)((x, xs) => Cons(x, xs))
  }

  /** Devuelve una IntList vacía */
  def empty: IntList = Empty

  /** Determina si una lista está vacía */
  def isEmpty(list: IntList): Boolean = list match {
    case Empty => true
    case _ => false
  }

  /** Devuelve el primer elemento de una lista
    *
    * @param list
    *   Una IntList
    * @return
    *   el primer elemento de `list`
    * @throws scala.NoSuchElementException
    *   si la lista está vacía
    */
  def head(list: IntList): Int = list match {
    case Empty => throw new NoSuchElementException
    case Cons(head, _) => head
  }

  /** Devuelve los elementos de una lista excepto el primero
    *
    * @param list
    *   Una IntList
    * @return
    *   los elementos de `list` excepto el primero
    * @throws scala.NoSuchElementException
    *   si la lista está vacía
    */
  def tail(list: IntList): IntList = list match {
    case Empty => throw new NoSuchElementException
    case Cons(_, tail) => tail
  }

  /** Devuelve la longitud de una lista */
  def length(list: IntList): Int = {
    @annotation.tailrec
    def lengthAcc(lst: IntList, acc: Int): Int = lst match {
      case Empty => acc
      case Cons(_, tail) => lengthAcc(tail, acc + 1)
    }
    lengthAcc(list, 0)
  }

  /** Aplica un operador binario a los elementos de una lista y a un valor
    * inicial, yendo de izquierda a derecha.
    *
    * @tparam T
    *   el tipo de retorno del operador binario.
    * @param z
    *   el valor inicial.
    * @param f
    *   el operador binario.
    * @param list
    *   una lista de enteros.
    * @return
    *   el resultado de insertar `f` entre elementos consecutivos de `list`,
    *   yendo de izquierda a derecha con el valor inicial `z` a la izquierda:
    * {{{
    *             f(...f(z, x_1), x_2, ..., x_n)
    * }}}
    * donde `x,,1,,, ..., x,,n,,` son los elementos de la lista
    */
  def foldl[T](z: T)(f: (T, Int) => T)(list: IntList): T = {
    list match {
      case Empty => z
      case Cons(head, tail) => foldl(f(z, head))(f)(tail)
    }
  }

  /** Aplica un operador binario a los elementos de una lista y a un valor
    * inicial, yendo de derecha a izquierda.
    *
    * @tparam T
    *   el tipo de retorno del operador binario.
    * @param z
    *   el valor inicial.
    * @param f
    *   el operador binario.
    * @param list
    *   una lista de enteros.
    * @return
    *   el resultado de insertar `f` entre elementos consecutivos de `list`,
    *   yendo de derecha a izquierda con el valor inicial `z` a la derecha:
    * {{{
    *             f(x_1, f(x_2, ... f(x_n, z)...))
    * }}}
    * donde `x,,1,,, ..., x,,n,,` son los elementos de la lista.
    */
  def foldr[T](z: T)(f: (Int, T) => T)(list: IntList): T = {
    list match {
      case Empty => z
      case Cons(head, tail) => f(head, foldr(z)(f)(tail))
    }
  }

  /** Variante de foldl que no tiene valor inicial, y por lo tanto no puede ser
    * aplicado a listas vacías.
    *
    * @param f
    *   el operador binario
    * @param list
    *   una lista de enteros
    * @return
    *   el resultado de aplicar el operador de izquierda a derecha, usando el
    *   primer elemento como valor inicial.
    * @throws scala.NoSuchElementException --> Pide No Such Element Exception pero en los tests se pide UnsupportedOperationException
    *   si la lista está vacía.
    */
  def foldl1(f: (Int, Int) => Int)(list: IntList): Int = {
    list match {
      case Empty => throw new UnsupportedOperationException("Lista vacía")
      case Cons(head, tail) => foldl(head)(f)(tail)
    }
  }


  /** Variante de foldr que no tiene valor inicial, y por lo tanto no puede ser
    * aplicado a listas vacías.
    *
    * @param f
    *   el operador binario
    * @param list
    *   una lista de enteros
    * @return
    *   el resultado de aplicar el operador de derecha a izquierda, usando el
    *   último elemento como valor inicial.
    * @throws scala.NoSuchElementException --> Pide No Such Element Exception pero en los tests se pide UnsupportedOperationException
    *   si la lista está vacía.
    */
  def foldr1(f: (Int, Int) => Int)(list: IntList): Int = {
    list match {
      case Empty => throw new UnsupportedOperationException("Lista vacía")
      case Cons(head, Empty) => head
      case Cons(head, tail) => f(head, foldr1(f)(tail))
    }
  }
  /** Devuelve una IntList con una progresión aritmética, con los números desde
    * `start` hasta `end` exclusive, con avances `step`.
    *
    * Si `step` es positivo, el último elemento es el mayor entero (`start` +
    * i*`step`) menor que `end`. Si `step` es negativo, el último elemento es el
    * menor entero (`start` + i*`step`) mayor que `end`. Si `step` se omite, es
    * igual a 1. `step` no puede ser 0
    *   - range(1,5) == IntList(1,2,3,4)
    *   - range(1,5,2) == IntList(1,3)
    *   - range(4,3) == IntList()
    *   - range(4,3,-1)== IntList(4)
    *
    * @param start
    *   el valor inicial de la secuencia.
    * @param end
    *   el valor final, excluido de la secuencia.
    * @param step
    *   el incremento entre valores de la secuencia.
    * @return
    *   una IntList
    * @throws scala.IllegalArgumentException
    *   si `step` es 0.
    */
  def range(start: Int, end: Int, step: Int = 1): IntList = (step, start, end) match {
    case (0, _, _) => throw new IllegalArgumentException
    case (_, x, y) if x == y => empty
    case (s, x, y) if s > 0 && x > y => empty
    case (s, x, y) if s < 0 && x < y => empty
    case _ => Cons(start, range(start + step, end, step))
  }

  /** Equivalente a range(0,end,1) */
  def range(end: Int): IntList = range(0, end)


  /** Devuelve la suma de los elementos de la lista */
  def sum(list: IntList): Int = foldl(0)(_ + _)(list)
  

  /** Devuelve el producto de los elementos de la lista */
  def product(list: IntList): Int = {
    foldl(1)(_ * _)(list)
  }

  /** Devuelve una String con los elementos de la lista separados por `sep`
    *
    *   - mkString(":")(IntList(1,2,3)) == "1:2:3"
    *   - mkString(":")(IntList()) == ""
    */
  def mkString(sep: String)(list: IntList): String = {
    list match {
      case Empty => ""
      case Cons(head, tail) => head.toString + (if (tail == Empty) "" else sep) + mkString(sep)(tail)
    }
  }

  /** Versión de `mkString` equivalente a `start`+`mkString`(sep)(list)+`end`
    *
    *   - mkString("[", "," , "]")(List()) = "[]"
    *   - mkString("[", "," , "]")(List(1,2,3)) = "[1,2,3]"
    */
  def mkString(start: String, sep: String, end: String)(list: IntList): String = {
    start + mkString(sep)(list) + end
  }
end IntList
