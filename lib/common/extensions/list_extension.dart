extension SquashConsecutiveExtension<T> on List<T> {
  List<T> squashConsecutive() {
    if (isEmpty) return [];
    List<T> result = [first];
    for (int i = 1; i < length; i++) {
      if (this[i] != this[i - 1]) {
        result.add(this[i]);
      }
    }
    return result;
  }
}
