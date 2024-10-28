package expr

import rational.*
import scala.util.{Try, Either, Left, Right}
import scala.collection.mutable.Stack
import scala.util.control.Breaks

/** Representa un operador binario */
enum BinaryOperator:
    /** Representa la suma 
     * 
     *  Su símbolo es la *string* `+`
     */
    case Plus
    /** Representa la resta
     * 
     *  Su símbolo es la *string* `-`
     */
    case Minus
    /** Representa la multiplicación
     * 
     * Su símbolo es la *string* `*`
     */
    case Times
    /** Representa la división
     * 
     * Su símbolo es la *string* "÷"
     */
    case Div
    /** Representa la exponenciación
     * 
     * Su símbolo es la *string* `pow`
     */
    case Pow

/** Representa un operador unario */
enum UnaryOperator:
  /** Representa el cambio de signo
   * 
   * Su símbolo es la *string* `neg`
   */
  case Neg
  /** Representa la inversa
   * 
   * Su símbolo es la *string* `inv`
   */
  case Inv
  /** Representa el valor absoluto
   * 
   * Su símbolo es la *string* `abs`
   */
  case Abs


/** Representa una expresión aritmética, la cual puede ser un número racional
 * (`Num`), una operación binaria (`BinOp`), o una operación unaria (`UnOp`).
 */
sealed trait Expr:
  /** Devuelve una representación simplificada de la expresión, colocando
   * paréntesis donde sea necesario para especificar precedencias.
   * 
   * Ejemplos
   * 
   * La representación de un `Num` es la que corresponde a número racional
   * que contiene.
   * 
   * Los valores negativos siempre se encierran entre paréntesis.
   * {{{
   * scala> val q = Rational(1,2)
   * val q: rational.Rational = 1/2
   * 
   * scala> val num = Num(q)
   * val num: expr.Num = Num(Rational(1,2))
   * 
   * scala> num.show
   * val res0: String = 1/2
   * 
   * scala> Num(-q).show
   * val res1: String = (-1/2)
   * }}}
   * 
   * La representación de un `BinOp` en el caso de la suma, resta,
   * multiplicación o división consiste en la representación de sus
   * dos operandos separados por el símbolo del operador correspondiente.
   * 
   * Se usan paréntesis donde sea necesario.
   * 
   * {{{
   * scala> val a = Num(Rational(1,2))
   * val a: expr.Num = Num(Rational(1,2))
   * 
   * scala> val b = Num(Rational(-1,4))
   * val b: expr.Num = Num(Rational(-1,4))
   * 
   * scala> val plus = BinOp(Plus,a,b)
   * val plus: expr.BinOp = BinOp(Plus,Num(Rational(1,2)),Num(Rational(-1,4)))
   * 
   * scala> plus.show
   * val res6: String = 1/2 + (-1/4)
   * 
   * scala> val minus = BinOp(Minus,a,b)
   * val minus: expr.BinOp = BinOp(Minus,Num(Rational(1,2)),Num(Rational(-1,4)))
   * 
   * scala> minus.show
   * val res7: String = 1/2 - (-1/4)
   * 
   * scala> val times = BinOp(Times,a,b)
   * val times: expr.BinOp = BinOp(Times,Num(Rational(1,2)),Num(Rational(-1,4)))
   * 
   * scala> times.show
   * val res8: String = 1/2 * (-1/4)
   * 
   * scala> val div = BinOp(Div,a,b)
   * val div: expr.BinOp = BinOp(Div,Num(Rational(1,2)),Num(Rational(-1,4)))
   * 
   * scala> div.show
   * val res9: String = 1/2 ÷ (-1/4)
   * 
   * scala> BinOp(Plus, plus, plus).show
   * val res10: String = 1/2 + (-1/4) + 1/2 + (-1/4)
   * 
   * scala> BinOp(Minus, plus, plus).show 
   * val res11: String = 1/2 + (-1/4) - (1/2 + (-1/4))
   * 
   * scala> BinOp(Times, plus, minus).show 
   * val res12: String = (1/2 + (-1/4)) * (1/2 - (-1/4))
   * 
   * scala> BinOp(Minus, times, plus).show
   * val res13: String = 1/2 * (-1/4) - (1/2 + (-1/4))
   * 
   * scala> BinOp(Minus, times, times).show 
   * val res14: String = 1/2 * (-1/4) - 1/2 * (-1/4)
   * 
   * scala> BinOp(Div, times, times).show
   * val res15: String = 1/2 * (-1/4) ÷ (1/2 * (-1/4))
   * 
   * scala> BinOp(Div, minus, div).show
   * val res16: String = (1/2 - (-1/4)) ÷ (1/2 ÷ (-1/4))
   * 
   * }}}
   * 
   * En el caso de `Pow` se utiliza notación de función.
   * 
   * {{{
   * scala> BinOp(Pow, times, times).show
   * val res17: String = pow(1/2 * (-1/4), 1/2 * (-1/4))
   * 
   * scala> BinOp(Div, times, BinOp(Pow,a,b)).show
   * val res18: String = 1/2 * (-1/4) ÷ pow(1/2, (-1/4))
   * }}}
   * 
   */
  def show: String = this match {
    case Num(r) => if (r < Rational.apply(0)) s"($r)" else r.toString
    case BinOp(op, left, right) => op match {
      case BinaryOperator.Plus => {
        val leftStr = left match {
          case BinOp(op, _, _) if op == BinaryOperator.Plus || op == BinaryOperator.Minus => s"${left.show}"
          case _ => left.show
        }
        val rightStr = right match {
          case BinOp(op, _, _) if op == BinaryOperator.Plus || op == BinaryOperator.Minus => s"(${right.show})"
          case _ => right.show
        }
        s"$leftStr + $rightStr"
      }
      case BinaryOperator.Minus => {
        val leftStr = left match {
          case BinOp(op, _, _) if op == BinaryOperator.Plus || op == BinaryOperator.Minus => s"${left.show}"
          case _ => left.show
        }
        val rightStr = right match {
          case BinOp(op, _, _) if op == BinaryOperator.Plus || op == BinaryOperator.Minus => s"(${right.show})"
          case _ => right.show
        }
        s"$leftStr - $rightStr"
      }
      case BinaryOperator.Times =>
        val leftStr = left match {
          case BinOp(op, _, _) if op == BinaryOperator.Plus || op == BinaryOperator.Minus => s"(${left.show})"
          case _ => left.show
        }
        val rightStr = right match {
          case BinOp(op, _, _) if op == BinaryOperator.Plus || op == BinaryOperator.Minus => s"(${right.show})"
          case _ => right.show
        }
        s"$leftStr * $rightStr"
      case BinaryOperator.Div =>
        val leftStr = left match {
          case BinOp(op, _, _) if op == BinaryOperator.Plus || op == BinaryOperator.Minus => s"(${left.show})"
          case _ => left.show
        }
        val rightStr = right match {
          case BinOp(op, _, _) if op == BinaryOperator.Plus || op == BinaryOperator.Minus => s"(${right.show})"
          case BinOp(op,_,_) if op == BinaryOperator.Times || op == BinaryOperator.Div => s"(${right.show})"
          case _ => right.show
        }
        s"$leftStr ÷ $rightStr"
      case BinaryOperator.Pow => s"pow(${left.show}, ${right.show})"
    }
    case UnOp(op, expr) => op match {
      case UnaryOperator.Neg => s"neg(${expr.show})"
      case UnaryOperator.Inv => s"inv(${expr.show})"
      case UnaryOperator.Abs => s"abs(${expr.show})"
    }
  }

  /** Evalúa una expresión y devuelve su resultado
   * 
   * Ejemplos:
   * 
   * {{{
   * scala> val n = Num(Rational(1,2))
   * val n: expr.Num = Num(Rational(1,2))
   * 
   * scala> n.eval
   * val res1: rational.Rational = 1/2
   * 
   * scala> val m = Num(Rational(1,3))
   * val m: expr.Num = Num(Rational(1,3))
   * 
   * scala> m.eval
   * val res2: rational.Rational = 1/3
   * 
   * scala> val zero = Num(Rational(0))
   * val zero: expr.Num = Num(Rational(0))
   * 
   * scala> UnOp(Neg,n).eval
   * val res3: rational.Rational = -1/2
   * 
   * scala> UnOp(Abs,UnOp(Neg,m)).eval
   * val res4: rational.Rational = 1/3
   * 
   * scala> UnOp(Inv,n)
   * val res5: expr.UnOp = UnOp(Inv,Num(Rational(1,2)))
   * 
   * scala> UnOp(Inv,n).eval 
   * val res6: rational.Rational = 2
   * 
   * scala> UnOp(Inv,zero).eval   
   * java.lang.IllegalArgumentException: requirement failed: El denominador no puede ser 0
   *   at scala.Predef$.require(Predef.scala:337)
   *   ... 38 elided
   * 
   * scala> BinOp(Plus,n,m).eval
   * val res8: rational.Rational = 5/6
   * 
   * scala> BinOp(Div,n,zero).eval
   * java.lang.IllegalArgumentException: requirement failed: El denominador no puede ser 0
   *   at scala.Predef$.require(Predef.scala:337)
   *   ... 38 elided
   * 
   * scala> BinOp(Pow,n,BinOp(Pow,UnOp(Inv,n),UnOp(Inv,n))).eval
   * val res10: rational.Rational = 1/16
   * }}}
   * 
   * @throws IllegalArgumentException , si la evaluación desencadena una división por cero.
   */
  def eval: Rational = this match {
    case Num(n) => {
      // si el numerador es 0 devolvemos rational 0
      // si el denominador es 1 devolvemos solo el numerador
      // si el denominador es distinto de 1 devolvemos el racional

      if (n.numer == 0) Rational(0)
      else if (n.denom == 1) Rational(n.numer)
      else Rational(n.numer, n.denom)
    }
    case UnOp(op, e) => op match {
      case UnaryOperator.Neg => -e.eval
      case UnaryOperator.Abs => e.eval.abs
      case UnaryOperator.Inv => 
        if (e.eval != Rational(0)) Rational(1) / e.eval
        else throw new IllegalArgumentException("El denominador no puede ser 0")
    }
    case BinOp(op, e1, e2) => op match {
      case BinaryOperator.Plus => e1.eval + e2.eval
      case BinaryOperator.Minus => e1.eval - e2.eval
      case BinaryOperator.Times => e1.eval * e2.eval
      case BinaryOperator.Div => 
        if (e2.eval != Rational(0)) e1.eval / e2.eval
        else throw new IllegalArgumentException("El denominador no puede ser 0")
      case BinaryOperator.Pow => 
        if (e2.eval.denom == 1) e1.eval.pow(e2.eval)
        else throw new IllegalArgumentException("El exponente no es entero")
    }
  }

  /** Evalúa una expresión y devuelve su resultado encapsulado en `Option[Rational]`
   * 
   * Ejemplos:
   * 
   * {{{
   * scala> val zero = Num(Rational(0))
   * val zero: expr.Num = Num(Rational(0))
   * 
   * scala> UnOp(Inv,zero).evalOption
   * val res0: Option[rational.Rational] = None
   * 
   * scala> val n = Num(Rational(1,2))
   * val n: expr.Num = Num(Rational(1,2))
   * 
   * scala> n.evalOption
   * val res1: Option[rational.Rational] = Some(1/2)
   * 
   * scala> val m = Num(Rational(1,3))
   * val m: expr.Num = Num(Rational(1,3))
   * 
   * scala> BinOp(Div,n,zero).evalOption
   * val res2: Option[rational.Rational] = None
   * 
   * scala> BinOp(Times,n,zero).evalOption
   * val res3: Option[rational.Rational] = Some(0)
   * 
   * scala> UnOp(Inv,BinOp(Times,BinOp(Pow,UnOp(Inv,n),UnOp(Inv,m)),m)).evalOption
   * val res4: Option[rational.Rational] = Some(3/8)
   * 
   * }}}
   * 
   * @returns `Some(q)` si la evaluación es exitosa, donde `q` es el resultado de la evaluación; y `None` si la evaluación falla.
   */
  def evalOption: Option[Rational] = this match {
    case Num(n) => Some(n)
    case UnOp(op, e) => op match {
      case UnaryOperator.Neg => Some(-e.eval)
      case UnaryOperator.Abs => Some(e.eval.abs)
      case UnaryOperator.Inv => e.evalOption.flatMap(r => if (r != Rational(0)) Some(Rational(1) / r) else None)
    }
    case BinOp(op, e1, e2) => op match {
      case BinaryOperator.Plus => for { r1 <- e1.evalOption; r2 <- e2.evalOption } yield r1 + r2
      case BinaryOperator.Minus => for { r1 <- e1.evalOption; r2 <- e2.evalOption } yield r1 - r2
      case BinaryOperator.Times => for { r1 <- e1.evalOption; r2 <- e2.evalOption } yield r1 * r2
      case BinaryOperator.Div => for { r1 <- e1.evalOption; r2 <- e2.evalOption if r2 != Rational(0) } yield r1 / r2
      case BinaryOperator.Pow => for { r1 <- e1.evalOption; r2 <- e2.evalOption if r2.denom == 1 } yield r1.pow(r2)
    }
  }
  
  /** Produce una *string* que representa la expresión.
   * El resultado es equivalente al necesario para construir la expresión.
   * 
   * {{{
   * scala> val m = Num(Rational(1,3))
   * val m: expr.Num = Num(Rational(1,3))
   * 
   * scala> val n = Num(Rational(1,2))
   * val n: expr.Num = Num(Rational(1,2))
   * 
   * scala> UnOp(Inv,BinOp(Times,BinOp(Pow,UnOp(Inv,n),UnOp(Inv,m)),m))
   * val res5: expr.UnOp = UnOp(Inv,BinOp(Times,BinOp(Pow,UnOp(Inv,Num(Rational(1,2))),UnOp(Inv,Num(Rational(1,3)))),Num(Rational(1,3))))
   * }}}
   * 
   */
  override def toString: String = this match {
    case Num(n) => {
      if (n.numer == 0) "Num(Rational(0))"
      else if (n.denom == 1) s"Num(Rational(${n.numer}))"
      else s"Num(Rational(${n.numer},${n.denom}))"
    }
    case UnOp(op, e) => op match {
      case UnaryOperator.Neg => s"UnOp(Neg,${e.toString})"
      case UnaryOperator.Abs => s"UnOp(Abs,${e.toString})"
      case UnaryOperator.Inv => s"UnOp(Inv,${e.toString})"
    }
    case BinOp(op, e1, e2) => op match {
      case BinaryOperator.Plus => s"BinOp(Plus,${e1.toString},${e2.toString})"
      case BinaryOperator.Minus => s"BinOp(Minus,${e1.toString},${e2.toString})"
      case BinaryOperator.Times => s"BinOp(Times,${e1.toString},${e2.toString})"
      case BinaryOperator.Div => s"BinOp(Div,${e1.toString},${e2.toString})"
      case BinaryOperator.Pow => s"BinOp(Pow,${e1.toString},${e2.toString})"
    }
  }


/** Representa un número racional */
case class Num(number: Rational) extends Expr
/** Representa la expresión que resulta de aplicar el operador binario
 * `op` a las expresiones `left` y `right`.
 */
case class BinOp(op: BinaryOperator, left: Expr, right: Expr) extends Expr
/** Representa la expresión que resulta de aplicar el operador unario
 * `op` a la expresión `expr`
 */
case class UnOp(op: UnaryOperator, expr: Expr) extends Expr

object Expr:
  /** Recibe una lista de *strings* e interpreta a cada elemento como
   * un componente de una expresión en Notación Polaca Inversa,
   * (*Reverse Polish Notation*, o **RPN**).
   * 
   * Cada elemento es, o bien un número racional, o un operador:
   * `+`, `-`, `*`, `÷`, `/`, `pow`, `abs`, `inv` o `neg`.
   * 
   * En este caso `/` es un sinónimo de `÷`.
   * 
   * Devuelve un resultado de tipo `Either[String, Expr]`. Si la lista
   * representa una expresión correcta, devuelve `Right(e)` donde `e` es un
   * valor de tipo `Expr`. En caso contrario, devuelve `Left(s)` donde `s`
   * es un mensaje de error.
   * 
   * Para procesar la lista se lee cada uno de los elementos en orden. Si
   * es un racional, se coloca en una pila. Si es un operador, se retiran
   * los operandos correspondientes de la pila, se aplica el operador, y se
   * agrega el resultado a la pila. Si es una *string* vacía, se ignora.
   * En cualquier otro caso se devuelve un mensaje de error.
   * 
   * Al terminar de procesar la lista debería haber un único elemento en la
   * pila, que es el resultado.
   * 
   * Ejemplos:
   * 
   * {{{
   * scala> Expr.parseRPN(List("1/2", "2", "+"))
   * val res8: Either[String, expr.Expr] = Right(BinOp(Plus,Num(Rational(1,2)),Num(Rational(2))))
   * 
   * scala> Expr.parseRPN(List("2", "3", "4", "/", "*", "inv", "neg"))
   * val res9: Either[String, expr.Expr] = Right(UnOp(Neg,UnOp(Inv,BinOp(Plus,Num(Rational(2)),BinOp(Div,Num(Rational(3)),Num(Rational(4)))))))
   * 
   * scala> Expr.parseRPN(List("2", "3", "4", "÷", "+", "inv", "neg"))
   * val res10: Either[String, expr.Expr] = Right(UnOp(Neg,UnOp(Inv,BinOp(Plus,Num(Rational(2)),BinOp(Div,Num(Rational(3)),Num(Rational(4)))))))
   * }}}
   * 
   * Si la lista está vacía, devuelve el mensaje de error "Nada que evaluar".
   * 
   * {{{
   * scala> Expr.parseRPN(List())
   * val res11: Either[String, expr.Expr] = Left(Nada que evaluar)
   * 
   * scala> Expr.parseRPN(List(""))
   * val res12: Either[String, expr.Expr] = Left(Nada que evaluar)
   * }}}
   * 
   * Si hay un elemento que no es ni un operador ni un racional, se devuelve
   * el mensaje de error "Elemento desconocido"
   * 
   * {{{
   * scala> Expr.parseRPN(List("x"))
   * val res0: Either[String, expr.Expr] = Left(Elemento desconocido: x)
   * 
   * scala> Expr.parseRPN(List("2", "3", "^"))
   * val res1: Either[String, expr.Expr] = Left(Elemento desconocido: ^)
   *
   * scala> Expr.parseRPN(List("1.5"))
   * val res5: Either[String, expr.Expr] = Left(Elemento desconocido: 1.5)
   * }}}
   * 
   * Si aparece un operador binario, y no hay suficientes operandos en la pila,
   * se devuelve el mensaje de error "Argumentos insuficientes"
   * 
   * {{{
   * scala> Expr.parseRPN(List("1", "2", "+", "*"))
   * val res2: Either[String, expr.Expr] = Left(Argumentos insuficientes para Times)
   * }}}
   * 
   * Si aparece un operador unario, y no hay un operando en la pila, se devuelve
   * el mensaje de error "Falta argumento"
   * 
   * {{{
   * scala> Expr.parseRPN(List("abs", "2"))
   * val res3: Either[String, expr.Expr] = Left(Falta argumento para Abs)
   * }}}
   * 
   * Si se terminó de procesar la lista, y queda más de una expresión en la
   * pila, se devuelve el mensaje de error "Faltan operadores"
   * 
   * {{{
   * scala> Expr.parseRPN(List("2", "1/4", "5", "-"))
   * val res4: Either[String, expr.Expr] = Left(Faltan operadores)
   * }}}
   */
  def parseRPN(e: List[String]): Either[String, Expr] = {
    def BinaryOperation(op: String, left: Expr, right: Expr) = op match {
      case "+" => BinOp(BinaryOperator.Plus, left, right)
      case "-" => BinOp(BinaryOperator.Minus, left, right)
      case "*" => BinOp(BinaryOperator.Times, left, right)
      case "/" => BinOp(BinaryOperator.Div, left, right)
      case "÷" => BinOp(BinaryOperator.Div, left, right)
      case "pow" => BinOp(BinaryOperator.Pow, left, right)
    }

    def UnaryOperation(op: String, expr: Expr) = op match {
        case "inv" => UnOp(UnaryOperator.Inv,expr)
        case "neg" => UnOp(UnaryOperator.Neg,expr)
        case "abs" => UnOp(UnaryOperator.Abs,expr)
    }

    object rational {
      def apply(s: String): Rational = {
        val rationalPattern = """^(-?\d+)/(\d+)$""".r
        val integerPattern = """^(-?\d+)$""".r
        s match {
          case rationalPattern(numerator, denominator) =>
            if (denominator.toInt != 0) {
              Rational(numerator.toInt, denominator.toInt)
            } else {
              throw new IllegalArgumentException("El denominador no puede ser 0")
            }
          case integerPattern(intValue) =>
            Rational(intValue.toInt, 1)
          case _ =>
            print(s"${s}")
            throw new IllegalArgumentException(s"Elemento desconocido: $s")
        }
      }
    }

    val stack = scala.collection.mutable.Stack[Expr]()
    var flag = 0

    if(e.length == 0 || e.forall(_.isEmpty)) {
      Left("Nada que evaluar")
    } else {
      for(value <- e) {
        if(flag == 0) {
          val token = value.replace(" ", "")
          if(token.nonEmpty) {
            if (token == "inv" || token == "neg" || token == "abs") {
              if (stack.size < 1) {
                flag = 1
              } else {
                val expr = stack.pop()
                val result = UnaryOperation(token, expr)
                stack.push(result)
              }
            } else if (token == "+" || token == "-" || token == "*" || token == "/"  || token == "÷"|| token == "pow") {        
              if (stack.size < 2) {
                flag = 2
              } else {
                val right = stack.pop()
                val left = stack.pop()
                val result = BinaryOperation(token, left, right)
                stack.push(result)
              }
            } else if (token.forall(c => c.isDigit) || (token.length > 2 && token.contains("/")) || (token.length > 1 && token.contains("-"))) {
              stack.push(Num(rational(token)))
            } else {
              flag = 3
            }
          }
        }
      }

      if(flag == 1) {
        Left("Falta argumento")
      } else if (flag == 2) {
        Left("Argumentos insuficientes")
      } else if(flag == 3) {
        Left("Elemento desconocido")
      } else if (stack.size != 1) {
        Left("Faltan operadores")
      } else {
        Right(stack.pop())
      }
    }
  }

    /** Recibe una *string*, y la interpreta como una expresión RPN formada por
     * operadores y operandos separados por espacios en blanco.
     * Su funcionamiento en consistente con el de la versión [[Expr.parseRPN(List[String])]] que recibe como argumento una lista de *strings*.
     * 
     * Ejemplos:
     * 
     * {{{
     * scala> Expr.parseRPN("2 3 5 + *")
   * val res6: Either[String, expr.Expr] = Right(BinOp(Times,Num(Rational(2)),BinOp(Plus,Num(Rational(3)),Num(Rational(5)))))
   * 
   * scala> Expr.parseRPN("1               5          +")
   * val res7: Either[String, expr.Expr] = Right(BinOp(Plus,Num(Rational(1)),Num(Rational(5))))
   * 
   * scala> Expr.parseRPN("")
   * val res8: Either[String, expr.Expr] = Left(Nada que evaluar)
   * 
   * scala> Expr.parseRPN("   ")
   * val res9: Either[String, expr.Expr] = Left(Nada que evaluar)
   * 
   * scala> Expr.parseRPN("2 3 * +")
   * val res10: Either[String, expr.Expr] = Left(Argumentos insuficientes para Plus)
   * 
   * scala> Expr.parseRPN("inv 1/2")
   * val res11: Either[String, expr.Expr] = Left(Falta argumento para Inv)
   * 
   * scala> Expr.parseRPN("1/2 1.2 +")
   * val res12: Either[String, expr.Expr] = Left(Elemento desconocido: 1.2)
   * 
   * scala> Expr.parseRPN("32/45")
   * val res13: Either[String, expr.Expr] = Right(Num(Rational(32,45)))
   * 
   * scala> Expr.parseRPN("3/2 4/5")
   * val res14: Either[String, expr.Expr] = Left(Faltan operadores)
   * }}}
     */
  def parseRPN(e: String): Either[String, Expr] = {
    val trimmed = e.trim
    if (trimmed.isEmpty) {
      Left("Nada que evaluar")
    } else {
      val list = trimmed.split("\\s+").filterNot(_.isEmpty).toList
      parseRPN(list)
    }
  }