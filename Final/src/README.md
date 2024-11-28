# Implementación Funcional de Números Racionales

Una implementación de números racionales en Python utilizando conceptos de programación funcional.

## Conceptos Funcionales Implementados

### Pattern Matching
```python
# En el constructor
match (self.numer, self.denom):
    case (_, 0): raise ValueError()
    case (n, d) if d < 0: # normalización
```

### Recursión
```python
def pow_recursive(base, n):
    match n:
        case 0: return Rational(1)
        case n if n < 0: return pow_recursive(base.inverse(), -n)
        case _: return base * pow_recursive(base, n - 1)
```

### Funciones de Orden Superior
```python
# Usando reduce, map y filter
sum_rationals(rationals)  # reduce para suma
map_rational(f, rational) # map para transformación
filter_rationals(pred, rationals) # filter
```

### Tipos Algebraicos
```python
class RationalValue(Enum):
    ZERO = (0, 1)
    ONE = (1, 1)
```

## Instalación y Uso

```python
from rational import Rational, sum_rationals

# Crear números racionales
r1 = Rational(1, 2)     # 1/2
r2 = Rational(3)        # 3

# Usar funciones de orden superior
nums = [r1, r2]
total = sum_rationals(nums)
```

## Testing
```bash
# Test básico
python -m unittest test_rational.py

# Test con output detallado
python -m unittest -v test_rational.py
```

## Características
- Inmutabilidad mediante `@dataclass(frozen=True)`
- Operaciones funcionales con map/reduce/filter
- Pattern matching para validación y manejo de casos
- Implementación recursiva de potencias

## Errores Comunes
- `ValueError`: Denominador 0
- `ValueError`: Potencias no enteras
- `ValueError`: Cero a potencia negativa
