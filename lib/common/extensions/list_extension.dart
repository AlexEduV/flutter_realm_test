extension IndexOrNullExtension on List {
  int? indexWhereOrNull<T>(bool Function(T) test) {
    final index = indexWhere(test as dynamic);
    return index == -1 ? null : index;
  }
}
