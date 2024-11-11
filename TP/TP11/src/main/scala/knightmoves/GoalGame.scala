package knightmoves

trait GoalGame extends BaseGame:
  /** El tipo Path define un camino como secuencia de posiciones */
  type Path = List[Pos]

  /** goal es la posición a la que se quiere llegar */
  val goal: Pos

  /** startPos es la posición de inicio */
  val startPos: Pos

  /** El método done recibe una posición y determina si se ha llegado a la
    * posición objetivo
    */
  def done(pos: Pos): Boolean = ???

  /** El método from es un método recursivo que genera una LazyList de conjuntos
    * de caminos.
    *
    * Cada camino es una secuencia de posiciones, en la que la posición de
    * origen está al final, y la primera posición corresponde al resultado del
    * último movimiento. El utilizar este orden permite extender el camino de
    * forma más eficiente.
    *
    * La LazyList está ordenada por longitud de camino. Es decir, primero están
    * el camino al origen (de longitud 0), después están todos los caminos de
    * longitud 1, después los de longitud 2, y así sucesivamente.
    */
  def from(initial: Set[Path], explored: Set[Pos]): LazyList[Set[Path]] = ???

  /** pathsFromStart es la LazyList que contiene todos los caminos que nacen en
    * startPos
    */
  lazy val pathsFromStart: LazyList[Set[Path]] = ???

  /** pathsToGoal contiene todos los caminos que llegan al destino.
    */
  lazy val pathsToGoal: LazyList[Path] = ???

  /** solution es de tipo Option[List[Pos]]. Si no existe ningún camino, su
    * valor es None. Si existen caminos, el valor es Some(path) donde path es un
    * camino de la longitud más corta posible.
    *
    * En este caso, el camino está en el orden natural, es decir, el primer
    * elemento de la lista corresponde a la posición de origen, y los
    * elementos siguientes corresponden a las sucesivas posiciones recorridas
    * hasta llegar al destino.
    */
  lazy val solution: Option[Path] = ???
end GoalGame
