extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;

    return this[0].toUpperCase() + substring(1);
  }

  String obscure() {
    if (isEmpty) return this;

    return '*' * length;
  }

  String camelCaseToTitle() {
    // Insert space before each uppercase letter
    String spaced = replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
    // Capitalize each word
    return spaced
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}
