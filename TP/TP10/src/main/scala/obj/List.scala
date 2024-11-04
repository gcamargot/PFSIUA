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
  def foldRight[B](z: B)(f: (A, B) => B): B = {
    def loop(xs: List[A], acc: B): B = xs match {
      case Empty => acc
      case x ::: xs => f(x, loop(xs, acc))
    }
    loop(this, z)
  }
  def foldLeft[B](z: B)(f: (B, A) => B): B = {
    def loop(xs: List[A], acc: B): B = xs match {
    case Empty => acc
    case x ::: xs => loop(xs, f(acc, x))
    }
    loop(this, z)
  }
  def reduceLeft[B >: A](f: (B, A) => B): B = {
    def loop(list: List[A], acc: B): B = list match {
      case Empty      => acc
      case (x ::: xs) => loop(xs, f(acc, x))
    }
    loop(this.tail, this.head)
  }
  def reduceRight[B >: A](f: (A, B) => B): B = this match {
    case Empty => throw new UnsupportedOperationException("reduceRight on empty list")
    case head ::: tail => if (tail.isEmpty) head else f(head, tail.reduceRight(f))
  }
  def min[B >: A](using cmp: Ordering[B]): A = {
    def loop(list: List[A], acc: A): A = list match {
      case Empty      => acc
      case (x ::: xs) => loop(xs, if cmp.lt(x, acc) then x else acc)
    }
    loop(this.tail, this.head)
  }
  def max[B >: A](using cmp: Ordering[B]): A = {
    def loop(list: List[A], acc: A): A = list match {
      case Empty      => acc
      case (x ::: xs) => loop(xs, if cmp.gt(x, acc) then x else acc)
    }
    loop(this.tail, this.head)
  }
  def sum[B >: A](using num: Numeric[B]): B = {
    def loop(xs: List[A], acc: B): B = xs match {
    case Empty => acc
    case x ::: xs => loop(xs, num.plus(x, acc))
    }
    loop(this, num.zero)
  }
  def product[B >: A](using num: Numeric[B]): B = {
    def loop(list: List[A], acc: B): B = list match {
      case Empty      => acc
      case (x ::: xs) => loop(xs, num.times(x, acc))
    }
    loop(this, num.one)
  }
  def reverse: List[A] = {
    def loop(list: List[A], acc: List[A]): List[A] = list match {
      case Empty      => acc
      case (x ::: xs) => loop(xs, x ::: acc)
    }
    loop(this, Empty)
  }
  def mkString(start: String, sep: String, end: String): String = {
    def loop(xs: List[A], acc: String): String = xs match {
      case Empty => acc
      case x ::: Empty => loop(Empty, acc + x.toString)
      case x ::: xs => loop(xs, acc + x.toString + sep)
    }
    start + loop(this, "") + end
  }
  def mkString(sep: String): String = {
    def loop(xs: List[A], acc: String): String = xs match {
      case Empty => acc
      case x ::: Empty => loop(Empty, acc + x.toString)
      case x ::: xs => loop(xs, acc + x.toString + sep)
    }
    loop(this, "")
  }
  def find(p: A => Boolean): Option[A] = {
    def loop(list: List[A]): Option[A] = list match {
      case Empty      => None
      case (x ::: xs) => if p(x) then Some(x) else loop(xs)
    }
    loop(this)
  }
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
