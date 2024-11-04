package obj

/** @author
  *   miguel
  */
trait List[+A]:
  def head: A
  def tail: List[A]
  def isEmpty: Boolean
  def length: Int
  def :::[B >: A](x: B): List[B] = obj.:::(x, this)
  def foldRight[B](z: B)(f: (A, B) => B): B = ???
  def foldLeft[B](z: B)(f: (B, A) => B): B = ???
  def reduceLeft[B >: A](f: (B, A) => B): B = ???
  def reduceRight[B >: A](f: (A, B) => B): B = ???
  def min[B >: A](using cmp: Ordering[B]): A = ???
  def max[B >: A](using cmp: Ordering[B]): A = ???
  def sum[B >: A](using num: Numeric[B]): B = ???
  def product[B >: A](using num: Numeric[B]): B = ???
  def reverse: List[A] = ???
  def mkString(start: String, sep: String, end: String): String = ???
  def mkString(sep: String): String = ???
  def find(p: A => Boolean): Option[A] = ???
  override def toString: String = "Reemplazar por una implementación adecuada"
end List

case object Empty extends List[Nothing]:
  def head: Nothing = throw new NoSuchElementException("Lista vacía")
  def tail: List[Nothing] = throw new UnsupportedOperationException(
    "Lista vacía"
  )
  val isEmpty: Boolean = true
  val length: Int = 0
end Empty

case class :::[A](head: A, tail: List[A]) extends List[A]:
  def isEmpty: Boolean = false
  def length: Int = 1 + tail.length

object List:
  def apply[A](args: A*): List[A] =
    args.foldRight(empty[A])((x, acc) => obj.:::(x, acc))
  def empty[A]: List[A] = Empty
end List
