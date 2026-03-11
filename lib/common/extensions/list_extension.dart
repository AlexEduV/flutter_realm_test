extension IndexOrNullExtension on List {
  int? indexWhereOrNull<T>(bool Function(dynamic) test) {
    final index = indexWhere(test);
    return index == -1 ? null : index;
  }
}
