# Final

## Ejercicio práctico

Implemente, en algún lenguaje de programación distinto de Haskell o Scala, una solución funcional a alguno de los problemas  enumerados más adelante. La solución debe trabajar con estructuras de datos inmutables, y utilizar las herramientas que hemos visto durante el desarrollo de la materia, tales como *pattern matching*, recursión, funciones de orden superior, tipos de datos algebraicos, etc.

### Implementación de un tipo de datos Racional
Debe implementarse un tipo de datos en el lenguaje elegido con características similares al tipo Rational que hemos implementado en Scala. Debe ser posible crear instancias de este tipo de datos a partir de un numerador y un denominador, y debe ser posible realizar las operaciones aritméticas básicas sobre instancias de este tipo de datos. Debe ser posible imprimir instancias de este tipo de datos en un formato legible por humanos. Debe ser posible utilizar instancias de este tipo de datos en tablas hash y en conjuntos.

### Implementación de un tipo de datos Complejo
Debe implementarse un tipo de datos que permita representar números complejos. Debe ser posible crear instancias de este tipo de datos a partir de un número real y un número imaginario, y debe ser posible realizar las operaciones aritméticas básicas sobre instancias de este tipo de datos. Debe ser posible imprimir instancias de este tipo de datos en un formato legible por humanos. Debe ser posible utilizar instancias de este tipo de datos en tablas hash y en conjuntos.

### Implementación de un tipo de datos Set
Debe implementarse un tipo de datos que permita representar conjuntos de elementos utilizando un árbol binario de búsqueda o una lista. Debe ser posible crear instancias de este tipo de datos a partir de una lista de elementos, y debe ser posible realizar las operaciones básicas entre conjuntos, tales como unión, intersección, diferencia, etc. Debe ser posible insertar y eliminar elementos de un conjunto. Los conjuntos deben ser inmutables, por lo que las operaciones de inserción y eliminación deben devolver un nuevo conjunto. Debe ser posible imprimir instancias de este tipo de datos en un formato legible por humanos. 

### Implementación de un tipo de datos Map
Debe implementarse un tipo de datos que permita representar mapas (o diccionarios) de elementos utilizando un árbol binario de búsqueda o una lista de pares. Debe ser posible crear instancias de este tipo de datos a partir de una lista de pares clave-valor, y debe ser posible realizar las operaciones básicas sobre mapas, tales como obtener el valor asociado a una clave, insertar y eliminar elementos, etc. Los mapas deben ser inmutables, por lo que las operaciones de inserción y eliminación deben devolver un nuevo mapa. Debe ser posible imprimir instancias de este tipo de datos en un formato legible por humanos.


El código debe ser subido a su repositorio al menos tres días antes del examen.

## Trabajo de investigación

Elija uno de los temas siguientes, para efectuar una presentación de 10 minutos sobre el tema en el examen final. Utilice los recursos de presentación que considere adecuados.

Elegido el tema, deberá anunciarlo en el grupo de Chat. No se pueden elegir temas repetidos, por lo que serán adjudicados por orden de llegada. 

### Tuplas y listas en Erlang
Erlang es un lenguaje funcional desarrollado originalmente para empresas de comunicaciones. Describa los concepto de tuplas y listas. ¿Cómo se utilizan las tuplas para indicar el éxito o fracaso de una función? ¿Cómo se construyen las listas? ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala?

[https://learnyousomeerlang.com/]()


### Listas en LISP y derivados
Investigue y describa el funcionamiento de listas en LISP o alguno de sus derivados, como Scheme o Racket. ¿Qué es un par? ¿Qué es una lista propia y una lista impropia? ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala?
¿Podrían implementarse listas de este estilo con tuplas en Python?

[https://racket-lang.org/]()


### Tipos de dato algebraicos en Rust
Rust es un lenguaje joven, que apunta a reemplazar a C para el desarrollo de sistemas. En particular tiene una sintaxis bastante sencilla para la definición de tipos de dato algebraicos. Investigue y describa la forma de trabajar con tipos de dato algebraicos. ¿Cómo funcionan los tipos Option y Result?

[https://doc.rust-lang.org/rust-by-example]()
[https://doc.rust-lang.org/book/]()

### Programación funcional en Kotlin
Kotlin es un lenguaje de programación desarrollado por JetBrains que corre sobre la máquina virtual de Java. Es un lenguaje multiparadigma, que permite programación funcional y el lenguaje preferido por Google para el desarrollo sobre Android. Investigue y describa la forma de trabajar con programación funcional en Kotlin. ¿Qué soporte tiene para conceptos como inmutabilidad, *pattern matching*, funciones de orden superior, tipos de datos algebraicos, recursividad, etc.? ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala?

[https://kotlinlang.org/]()

### Programación funcional en F#
F# es un lenguaje de programación funcional desarrollado por Microsoft que corre sobre la máquina virtual de .NET. Investigue y describa la forma de trabajar con programación funcional en F#. ¿Qué soporte tiene para conceptos como inmutabilidad, *pattern matching*, funciones de orden superior, tipos de datos algebraicos, recursividad, etc.? ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala?

[https://fsharp.org/]()

### Programación funcional en Clojure
Clojure es un lenguaje de programación funcional desarrollado por Rich Hickey que corre sobre la máquina virtual de Java. Investigue y describa la forma de trabajar con programación funcional en Clojure. ¿Qué soporte tiene para conceptos como inmutabilidad, *pattern matching*, funciones de orden superior, tipos de datos algebraicos, recursividad, etc.? ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala?

[https://clojure.org/]()

### Programación funcional en Elixir
Elixir es un lenguaje de programación funcional desarrollado por José Valim que corre sobre la máquina virtual de Erlang. Investigue y describa la forma de trabajar con programación funcional en Elixir. ¿Qué soporte tiene para conceptos como inmutabilidad, *pattern matching*, funciones de orden superior, tipos de datos algebraicos, recursividad, etc.? ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala?

[https://elixir-lang.org/]()

### *Pattern matching* en Java, C# y Python
Java, C# y Python son tres lenguajes que han incorporado *pattern matching* en sus últimas versiones. Investigue y describa la forma de trabajar con *pattern matching* en estos lenguajes. ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala?

[https://docs.microsoft.com/en-us/dotnet/csharp/pattern-matching]()
[https://openjdk.org/jeps/394]()
[https://openjdk.org/jeps/440]()
[https://openjdk.org/jeps/441]()
[https://www.python.org/dev/peps/pep-0636/]()

### *Pattern matching* en Rust
Rust es un lenguaje joven, que apunta a reemplazar a C para el desarrollo de sistemas. En particular tiene una sintaxis bastante sencilla para el *pattern matching*. Investigue y describa la forma de trabajar con *pattern matching* en Rust. ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala?

### *Data classes* en Java, C# y Python
Los lenguajes orientados a objectos suelen utilizar clases tanto para modelar datos como para modelar comportamientos. Cuando se desea utilizar un enfoque más funcional a menudo hace falta una forma de modelar datos sin comportamiento y los enfoques tradicionales requieren la escritura de mucho código repetitivo. Java, C# y Python son tres lenguajes que han incorporado el concepto de *data classes* en sus últimas versiones, aunque no necesariamente con ese nombre.  ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala? ¿Qué soporte tienen para inmutabilidad?

[https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-9#record-types]()
[https://openjdk.java.net/jeps/395]()
[https://www.python.org/dev/peps/pep-0557/]()

### Funciones de orden superior en Java
Se llaman funciones de orden superior a aquellas funciones que reciben como parámetro otras funciones o que devuelven funciones como resultado. En Java las funciones de orden superior se implementan mediante interfaces funcionales. Investigue y describa la forma de trabajar con funciones de orden superior en Java. ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala? ¿Qué interfaces funcionales están definidas en la biblioteca estándar de Java?

[https://docs.oracle.com/javase/8/docs/api/java/util/function/package-summary.html]()

### Funciones de orden superior en C#
Se llaman funciones de orden superior a aquellas funciones que reciben como parámetro otras funciones o que devuelven funciones como resultado. En C# las funciones de orden superior se implementan mediante delegados y expresiones lambda. Investigue y describa la forma de trabajar con funciones de orden superior en C#. ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala? 

[https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/lambda-expressions]()
[https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/delegates/]()

### Funciones de orden superior en Python
Se llaman funciones de orden superior a aquellas funciones que reciben como parámetro otras funciones o que devuelven funciones como resultado. Investigue y describa la forma de trabajar con funciones de orden superior en Python. ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala? ¿Qué funciones de orden superior están definidas en la biblioteca estándar de Python? ¿Qué es un decorador?

[https://docs.python.org/3/library/functools.html]()
[https://docs.python.org/3/library/itertools.html]()
[https://docs.python.org/3/library/operator.html]()

### Funciones de orden superior en JavaScript
Se llaman funciones de orden superior a aquellas funciones que reciben como parámetro otras funciones o que devuelven funciones como resultado. Investigue y describa la forma de trabajar con funciones de orden superior en JavaScript. ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala? ¿Qué funciones de orden superior están definidas en la biblioteca estándar de JavaScript? ¿Qué diferencias existen entre las distintas formas de construir funciones anónimas?

[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/function]()
[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions]()

### Funciones de orden superior en Rust
Se llaman funciones de orden superior a aquellas funciones que reciben como parámetro otras funciones o que devuelven funciones como resultado. Investigue y describa la forma de trabajar con funciones de orden superior en Rust. ¿Qué similitudes y diferencias tienen con lo que vimos en Haskell y Scala? ¿Qué funciones de orden superior están definidas en la biblioteca estándar de Rust? ¿Qué es un iterador? ¿Qué son los *closures*?

[https://doc.rust-lang.org/rust-by-example]()
[https://doc.rust-lang.org/book/]()





