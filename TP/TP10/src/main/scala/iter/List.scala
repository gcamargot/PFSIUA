package iter

/** Implementa una lista extendiendo el trait Iterable
  */
trait List[+A] extends Iterable[A]:
  def :::[B >: A](x: B): List[B] = iter.:::(x, this)
  def iterator: Iterator[A] = {
    def loop(xs: List[A]): Iterator[A] = xs match {
      case Empty      => Iterator.empty
      case (x ::: xs) => Iterator(x) ++ loop(xs)
    }
    loop(this)
  }
  def length: Int = this match
    case Empty      => 0
    case (x ::: xs) => 1 + xs.length
  override def toString: String = {
    def loop(list: List[A], acc: String): String = list match {
      case Empty      => acc
      case (x ::: xs) => loop(xs, acc + ", " + x.toString)
    }
    "List(" + loop(this, "") + ")"
  }
end List

case object Empty extends List[Nothing]

case class :::[A](override val head: A, override val tail: List[A])
    extends List[A]

object List:
  def apply[A](args: A*): List[A] = args.foldRight(Empty: List[A])(_ ::: _)
  def empty[A]: List[A] = Empty
