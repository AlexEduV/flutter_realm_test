extension IndexOrNullExtension<T> on List<T> {
  int? indexWhereOrNull(bool Function(T) test) {
    final index = indexWhere(test);
    return index == -1 ? null : index;
  }
}

extension NotEmptyAndContains<T> on List<T> {
  bool isNotEmptyAndNotContains(Object? element) {
    return isNotEmpty && !contains(element);
  }
}
