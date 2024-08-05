/*
 ============================================================================
 Name        : sum.c
 Author      : Miguel Montes
 Version     : 2018
 Description : Funciones que suman los elementos de un array
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>

int sum_ints(int a[], size_t n) {
  int s = 0;
  int i;
  for (i = 0; i < n; i++) s += a[i];
  return s;
}

double sum_doubles(double a[], size_t n) {
  double s = 0;
  int i;
  for (i = 0; i < n; i++) s += a[i];
  return s;
}

int main(void) {
  int int_array[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  double double_array[] = {1.0, 2.0, 3.1};
  printf("ints: %d, doubles: %g\n", sum_ints(int_array, 10),
         sum_doubles(double_array, 3));
  return EXIT_SUCCESS;
}
