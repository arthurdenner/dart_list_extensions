/// Extension methods for any [Iterable].
extension IterableExtensions<E> on Iterable<E> {
  /// Returns count of elements that satisfy the predicate [test].
  int countWhere(bool test(E element)) =>
      this.fold(0, (count, e) => test(e) ? count + 1 : count);

  /// Returns sum of int values by elements.
  ///
  /// [getVal] should return value for sum up. It can be property of element,
  /// or any another value by element.
  int sumOf(int getVal(E element)) => this.fold(0, (sum, e) => sum + getVal(e));

  /// Returns sum of double values by elements.
  ///
  /// [getVal] should return value for sum up. It can be property of element,
  /// or any another value by element.
  double sumOfDouble(double getVal(E element)) =>
      this.fold(0, (sum, e) => sum + getVal(e));
}

/// Extension methods for [Iterable] of int.
extension IntIterableExtensions on Iterable<int> {
  /// Returns sum of values.
  int sum() => this.fold(0, (sum, v) => sum + v);
}

/// Extension methods for [Iterable] of double.
extension DoubleIterableExtensions on Iterable<double> {
  /// Returns sum of values.
  double sum() => this.fold(0, (sum, v) => sum + v);
}