extension IndexOrNullExtension<T> on List<T> {
  int? indexWhereOrNull(bool Function(T) test) {
    final index = indexWhere(test);
    return index == -1 ? null : index;
  }
}
