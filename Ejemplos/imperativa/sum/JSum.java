
public class JSum {

	public static int sumArray(int[] xs) {
		int sum = 0;
		for (int x : xs)
			sum += x;
		return sum;
	}

	public static double sumArray(double[] xs) {
		double sum = 0;
		for (double x : xs)
			sum += x;
		return sum;
	}

	public static void main(String[] args) {
		int[] intArray = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
		double[] doubleArray = { 1.0, 2.0, 3.1 };
		String[] stringArray = { "a", "b", "c" };
		System.out.printf("ints: %d, doubles: %g%n", sumArray(intArray), sumArray(doubleArray));
	}
}
