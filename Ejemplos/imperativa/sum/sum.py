#!/usr/bin/env python3
"""Ejemplo de función que suma los elementos de un arreglo."""

def sum_array(xs):
    """Suma los elementos de un arreglo."""
    s = 0
    for x in xs:
        s += x
    return s


if __name__ == "__main__":
    int_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    double_array = [1.0, 2.0, 3.1]
    string_array = ["a", "b", "c"]
    print("ints:", sum_array(int_array), ", doubles:", sum_array(double_array))
    # La siguiente función generará un error de ejecución
    # print("strings:", sum_array(string_array))
