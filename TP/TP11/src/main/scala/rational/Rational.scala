package rational

given Numeric[Rational] with
  def fromInt(x: Int): Rational = ???
  def plus(x: Rational, y: Rational) = ???
  def minus(x: Rational, y: Rational): Rational = ???
  def negate(x: Rational): Rational = ???
  def times(x: Rational, y: Rational): Rational = ???
  def toDouble(x: Rational): Double = ???
  def toFloat(x: Rational): Float = ???
  def toInt(x: Rational): Int = ???
  def toLong(x: Rational): Long = ???
  def compare(x: Rational, y: Rational): Int = ???
  def parseString(s: String): Option[Rational] = ???
