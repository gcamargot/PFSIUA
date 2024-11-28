from dataclasses import dataclass
from functools import reduce
from math import gcd
from typing import Self, Union, Callable, Optional
from enum import Enum

class RationalValue(Enum):
    ZERO = (0, 1)
    ONE = (1, 1)

@dataclass(frozen=True)
class Rational:
    numer: int
    denom: int = 1

    def __post_init__(self):
        # Pattern matching para validación y normalización
        match (self.numer, self.denom):
            case (_, 0):
                raise ValueError("El denominador no puede ser 0")
            case (n, d) if d < 0:
                object.__setattr__(self, 'numer', -n)
                object.__setattr__(self, 'denom', -d)
            case _:
                self._simplify()

    def _simplify(self):
        def simplify_vals(n: int, d: int) -> tuple[int, int]:
            g = abs(gcd(n, d))
            return (n // g, d // g)
        
        n, d = simplify_vals(self.numer, self.denom)
        object.__setattr__(self, 'numer', n)
        object.__setattr__(self, 'denom', d)

    @classmethod
    def from_string(cls, s: str) -> Self:
        def parse_rational(s: str) -> Optional[tuple[int, int]]:
            match s.split('/'):
                case [n] if n.strip('-').isdigit():
                    return (int(n), 1)
                case [n, d] if n.strip('-').isdigit() and d.strip('-').isdigit():
                    return (int(n), int(d))
                case _:
                    return None

        match parse_rational(s):
            case None:
                raise ValueError(f"Invalid format: {s}")
            case (n, d):
                return cls(n, d)

    def apply_op(self, other: Union[Self, int], op: Callable[[int, int, int, int], tuple[int, int]]) -> Self:
        match other:
            case Rational(n2, d2):
                n, d = op(self.numer, self.denom, n2, d2)
            case int(n2):
                n, d = op(self.numer, self.denom, n2, 1)
            case _:
                return NotImplemented
        return Rational(n, d)

    def __add__(self, other: Union[Self, int]) -> Self:
        return self.apply_op(other, lambda n1, d1, n2, d2: (n1 * d2 + n2 * d1, d1 * d2))

    def __sub__(self, other: Union[Self, int]) -> Self:
        return self.apply_op(other, lambda n1, d1, n2, d2: (n1 * d2 - n2 * d1, d1 * d2))

    def __mul__(self, other: Union[Self, int]) -> Self:
        return self.apply_op(other, lambda n1, d1, n2, d2: (n1 * n2, d1 * d2))

    def __truediv__(self, other: Union[Self, int]) -> Self:
        match other:
            case Rational(0, _) | 0:
                raise ValueError("División por cero")
        return self.apply_op(other, lambda n1, d1, n2, d2: (n1 * d2, d1 * n2))

    def __pow__(self, other: Union[Self, int]) -> Self:
        def pow_recursive(base: Self, n: int) -> Self:
            match n:
                case 0: return Rational(1)
                case 1: return base
                case n if n < 0:
                    if base.numer == 0:
                        raise ValueError("No se puede elevar cero a potencia negativa")
                    return pow_recursive(base.inverse(), -n)
                case _: return base * pow_recursive(base, n - 1)

        match other:
            case Rational(n, 1):
                return pow_recursive(self, n)
            case Rational(_, _):
                raise ValueError("Solo se permiten potencias enteras")
            case int(n):
                return pow_recursive(self, n)
            case _:
                return NotImplemented

    def inverse(self) -> Self:
        match (self.numer, self.denom):
            case (0, _):
                raise ValueError("No se puede invertir cero")
            case (n, d):
                return Rational(d, n)

    def __eq__(self, other: object) -> bool:
        match other:
            case Rational(n2, d2):
                return self.numer == n2 and self.denom == d2
            case int(n):
                return self == Rational(n)
            case _:
                return NotImplemented

    def __lt__(self, other: Union[Self, int]) -> bool:
        match other:
            case Rational(n2, d2):
                return self.numer * d2 < n2 * self.denom
            case int(n):
                return self < Rational(n)
            case _:
                return NotImplemented

    def __hash__(self) -> int:
        return hash((self.numer, self.denom))

    def __str__(self) -> str:
        match (self.numer, self.denom):
            case (_, 1):
                return str(self.numer)
            case (n, d):
                return f"{n}/{d}"

    def __repr__(self) -> str:
        return f"Rational({self.numer}, {self.denom})"

# Funciones de orden superior para operaciones con racionales
def sum_rationals(rationals) -> Rational:
    return reduce(lambda x, y: x + y, rationals, Rational(0))

def product_rationals(rationals) -> Rational:
    return reduce(lambda x, y: x * y, rationals, Rational(1))

def map_rational(f: Callable[[int], int], rational: Rational) -> Rational:
    return Rational(f(rational.numer), f(rational.denom))

def filter_rationals(pred: Callable[[Rational], bool], rationals) -> list[Rational]:
    return list(filter(pred, rationals))