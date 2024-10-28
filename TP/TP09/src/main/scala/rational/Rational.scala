package rational

object RationalString:
    /** Descompone una *string* en un Rational.
     *
     * {{{
     * scala> RationalString.unapply("1")
     * val res0: Option[rational.Rational] = Some(1)
     * 
     * scala> RationalString.unapply("1/2")
     * val res1: Option[rational.Rational] = Some(1/2)     * 
     * scala> RationalString.unapply("1/0")
     * val res2: Option[rational.Rational] = None
     * 
     * scala> RationalString.unapply("x")
     * val res3: Option[rational.Rational] = None
     * 
     * scala> def isRational(s: String) = s match
     *      |   case RationalString(_) => true
     *      |   case _ => false
     *      | 
     * def isRational(s: String): Boolean
     * 
     * scala> isRational("99")
     * val res4: Boolean = true
     * 
     * scala> isRational("1.2")
     * val res5: Boolean = false
     * 
     * scala> isRational("0/0")
     * val res6: Boolean = false
     * 
     * }}}
     * 
     * @returns Some(q) si la string representa un racional `q`, None en caso contrario.
     */
    def unapply(s: String): Option[Rational] = ???

extension (r: Rational)
    /** Devuelve el valor absoluto de un racional
     * 
     * {{{
     * scala> Rational(1,2).abs
     * val res0: rational.Rational = 1/2
     * 
     * scala> Rational(-1,2).abs
     * val res1: rational.Rational = 1/2
     * 
     * scala> Rational(0).abs
     * val res2: rational.Rational = 0
     * }}}
     */
    def abs: Rational = ???

    /** Eleva un racional a una potencia racional, que debe ser entera
     * 
     * {{{
     * scala> Rational(1,2).pow(Rational(10))
     * val res0: rational.Rational = 1/1024
     * 
     * scala> Rational(1,2).pow(Rational(0))
     * val res1: rational.Rational = 1
     * 
     * scala> Rational(1,4).pow(Rational(1,2))
     * java.lang.IllegalArgumentException: El exponente no es entero
     *   at rational.Rational$package$.pow(Rational.scala:61)
     *   ... 38 elided
     * 
     * scala> Rational(0).pow(Rational(5)
     * 
     * scala> Rational(1,2).pow(Rational(-5)
     * val res4: rational.Rational = 32
     * 
     * scala> Rational(0).pow(Rational(-5)
     * java.lang.IllegalArgumentException: requirement failed: El denominador
     * no puede ser 0
     *   at scala.Predef$.require(Predef.scala:337)
     *   ... 38 elided
     * }}}
     * 
     * @throws IllegalArgumentException , si el exponente no es entero, o si la
     * base es cero y el exponente es negativo.
     */
    def pow(e: Rational) = ???

  
extension (r: Rational.type)
    /** Descompone un racional en su numerador y denominador
     * Es un patrón irrefutable.
     * 
     * {{{
     * scala> val one = Rational(1)
     * val one: rational.Rational = 1
     * 
     * scala> val q = Rational(1,2)
     * val q: rational.Rational = 1/2
     * 
     * scala> def isInt(r: Rational) = r match
     *      |   case Rational(_,1) => true
     *      |   case _ => false
     *      | 
     * def isInt(r: rational.Rational): Boolean
     * 
     * scala> isInt(one)
     * val res7: Boolean = true
     * 
     * scala> isInt(q)
     * val res8: Boolean = false
     * 
     * scala> val Rational(n,d) = q
     * val n: Int = 1
     * val d: Int = 2
     * }}}
     */
    def unapply(q: Rational): Some[(Int, Int)] = ???

