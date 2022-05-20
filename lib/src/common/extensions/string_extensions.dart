extension StringExtension on String {
  String get trimToFixedString {
    return length > 14 ? '${substring(0, 14)}...' : this;
  }
}
