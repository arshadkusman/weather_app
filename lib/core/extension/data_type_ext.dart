extension IntRange on int {
  bool isBetween(int lowerBound, int upperBound, {bool inclusive = true}) {
    return inclusive
        ? this >= lowerBound && this <= upperBound
        : this > lowerBound && this < upperBound;
  }
}

extension DoubleRange on double {
  bool isBetween(double lowerBound, double upperBound, {bool inclusive = true}) {
    return inclusive
        ? this >= lowerBound && this <= upperBound
        : this > lowerBound && this < upperBound;
  }
}

extension StringIsUrl on String {
  bool isUrl() => startsWith('https://');
}

extension StringIsSVG on String {
  bool isSVG() => endsWith('.svg');
}
