package rational

given Numeric[Rational] with
  def fromInt(x: Int): Rational = 
    Rational(x)

  def plus(x: Rational, y: Rational) = 
    x + y

  def minus(x: Rational, y: Rational): Rational = 
    x - y

  def negate(x: Rational): Rational = 
    -x

  def times(x: Rational, y: Rational): Rational = 
    x * y

  def toDouble(x: Rational): Double = 
    x.numer.toDouble / x.denom.toDouble

  def toFloat(x: Rational): Float = 
    x.numer.toFloat / x.denom.toFloat

  def toInt(x: Rational): Int = 
    (x.numer / x.denom)

  def toLong(x: Rational): Long = 
    (x.numer.toLong / x.denom.toLong)

  def compare(x: Rational, y: Rational): Int = 
    x.compare(y)

  def parseString(str: String): Option[Rational] = 
    try {
      Some(Rational(str))
    } catch {
      case _: NumberFormatException | _: IllegalArgumentException => None
    }