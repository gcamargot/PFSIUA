//============================================================================
// Name        : sum.cpp
// Author      : Miguel Montes
// Version     : 2018
// Description : Ejemplo de función que suma los elementos de un array
//============================================================================

#include <iostream>
using namespace std;

// int sum_array(int a[], size_t n){
//	int s = 0;
//	for (unsigned i = 0; i < n; i++)
//		s += a[i];
//	return s;
//}
//
// double sum_array(double a[], size_t n){
//	double s = 0;
//	for (unsigned i = 0; i < n; i++)
//		s += a[i];
//	return s;
//}

template <typename T>
T sum_array(T a[], size_t n) {
  T s = 0;
  for (unsigned i = 0; i < n; i++) s += a[i];
  return s;
}

int main() {
  int int_array[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  double double_array[] = {1.0, 2.0, 3.1};
  string string_array[] = {"a", "b", "c"};
  cout << "ints: " << sum_array(int_array, 10)
       << ", doubles: " << sum_array(double_array, 3) << endl;
  return 0;
}
