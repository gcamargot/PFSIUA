import unittest
import random
from rational import Rational

def random_rational():
    return Rational(
        random.randint(-1000, 1000),
        random.randint(1, 1000)
    )

class TestRational(unittest.TestCase):
    def test_creation(self):
        """Test rational creation and simplification"""
        for _ in range(10):
            n, d = random.randint(-100, 100), random.randint(1, 100)
            r = Rational(n, d)
            # Verificar que la fracción mantiene la misma proporción
            self.assertEqual(
                r.numer * d,
                n * r.denom
            )
            # Verificar que el denominador es positivo
            self.assertGreater(r.denom, 0)

    def test_addition(self):
        """Test addition with random rationals"""
        for _ in range(10):
            r1, r2 = random_rational(), random_rational()
            result = r1 + r2
            expected = Rational(
                r1.numer * r2.denom + r2.numer * r1.denom,
                r1.denom * r2.denom
            )
            self.assertEqual(result, expected)

    def test_subtraction(self):
        """Test subtraction with random rationals"""
        for _ in range(10):
            r1, r2 = random_rational(), random_rational()
            result = r1 - r2
            expected = Rational(
                r1.numer * r2.denom - r2.numer * r1.denom,
                r1.denom * r2.denom
            )
            self.assertEqual(result, expected)

    def test_multiplication(self):
        """Test multiplication with random rationals"""
        for _ in range(10):
            r1, r2 = random_rational(), random_rational()
            result = r1 * r2
            expected = Rational(r1.numer * r2.numer, r1.denom * r2.denom)
            self.assertEqual(result, expected)

    def test_division(self):
        """Test division with random rationals"""
        for _ in range(10):
            r1 = random_rational()
            r2 = random_rational()
            if r2.numer != 0:
                result = r1 / r2
                expected = Rational(r1.numer * r2.denom, r1.denom * r2.numer)
                self.assertEqual(result, expected)

    def test_power(self):
        """Test power operations with random rationals"""
        for _ in range(10):
            r = random_rational()
            n = random.randint(-5, 5)
            if n >= 0 or r.numer != 0:
                result = r ** n
                expected = Rational(r.numer ** abs(n), r.denom ** abs(n))
                if n < 0:
                    expected = Rational(expected.denom, expected.numer)
                self.assertEqual(result, expected)

    def test_comparisons(self):
        """Test comparisons between random rationals"""
        for _ in range(10):
            r1, r2 = random_rational(), random_rational()
            self.assertEqual(
                r1 < r2,
                r1.numer * r2.denom < r2.numer * r1.denom
            )

    def test_hash(self):
        """Test hash consistency with random rationals"""
        for _ in range(10):
            r1 = random_rational()
            r2 = Rational(r1.numer * 2, r1.denom * 2)
            self.assertEqual(hash(r1), hash(r2))

    def test_string_conversion(self):
        """Test string conversion and parsing with random rationals"""
        for _ in range(10):
            r1 = random_rational()
            r2 = Rational.from_string(str(r1))
            self.assertEqual(r1, r2)

    def test_inverse(self):
        """Test inverse operation with random rationals"""
        for _ in range(10):
            r = random_rational()
            if r.numer != 0:
                inv = r.inverse()
                self.assertEqual(r * inv, Rational(1))

    def test_fractional_power(self):
        """Test that fractional powers raise ValueError"""
        for n in range(-10, 11):
            if n == 0:
                continue
            for d in range(1, 11):
                for e in range(2, 7):
                    with self.assertRaises(ValueError):
                        Rational(n, d) ** Rational(1, e)

if __name__ == '__main__':
    unittest.main(verbosity=2)