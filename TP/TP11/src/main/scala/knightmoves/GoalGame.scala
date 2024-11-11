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
  def done(pos: Pos): Boolean = pos == goal

  /** El método from es un método recursivo que genera una LazyList de conjuntos
    * de caminos.
    *
    * Cada camino es una secuencia de posiciones, en la que la posición de
    * origen está al final, y la primera posición corresponde al resultado del
    * último movimiento.
    */
  def from(initial: Set[Path], explored: Set[Pos]): LazyList[Set[Path]] =
    if initial.isEmpty then LazyList.empty
    else
      val newPaths = for {
        path <- initial
        currentPos = path.head
        nextPos <- legalNeighbors(currentPos)
        if !explored.contains(nextPos)
      } yield nextPos :: path

      // Agrupar por la posición final y seleccionar un solo camino por posición
      val uniquePaths = newPaths
        .groupBy(_.head)
        .values
        .map(_.head)
        .toSet

      val newExplored = explored ++ uniquePaths.map(_.head)
      initial #:: from(uniquePaths, newExplored)

  /** pathsFromStart es la LazyList que contiene todos los caminos que nacen en
    * startPos
    */
  lazy val pathsFromStart: LazyList[Set[Path]] = 
    from(Set(List(startPos)), Set(startPos))

  /** pathsToGoal contiene todos los caminos que llegan al destino.
    * Los caminos van desde el objetivo hacia la posición inicial.
    */
  lazy val pathsToGoal: LazyList[Path] = 
    for {
      paths <- pathsFromStart
      path <- paths
      if done(path.head)
    } yield path  // Mantiene el orden desde el objetivo hacia el inicio

  /** solution es de tipo Option[List[Pos]]. Si no existe ningún camino, su
    * valor es None. Si existen caminos, el valor es Some(path) donde path es un
    * camino de la longitud más corta posible.
    *
    * El camino va desde la posición inicial hasta el objetivo.
    */
  lazy val solution: Option[Path] = 
    pathsToGoal.headOption.map(_.reverse)  // Revertimos el orden para solution
end GoalGame