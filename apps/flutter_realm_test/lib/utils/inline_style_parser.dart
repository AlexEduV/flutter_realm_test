import 'package:flutter/widgets.dart';

/// Parses a string with inline markdown-lite markers into styled [TextSpan]s.
/// Supports `_italic_`, `-strikethrough-`, and `*bold*`.
List<TextSpan> parseInlineStyles(String text) {
  final spans = <TextSpan>[];
  final regex = RegExp(r'(_[^_]+_|-[^-]+-|\*[^*]+\*)');
  final matches = regex.allMatches(text);

  int currentIndex = 0;

  for (final match in matches) {
    if (match.start > currentIndex) {
      spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
    }

    final matchedText = match.group(0)!;
    final content = matchedText.substring(1, matchedText.length - 1);

    final TextStyle style;
    if (matchedText.startsWith('_')) {
      style = const TextStyle(fontStyle: FontStyle.italic);
    } else if (matchedText.startsWith('-')) {
      style = const TextStyle(decoration: TextDecoration.lineThrough);
    } else {
      style = const TextStyle(fontWeight: FontWeight.bold);
    }

    spans.add(TextSpan(text: content, style: style));
    currentIndex = match.end;
  }

  if (currentIndex < text.length) {
    spans.add(TextSpan(text: text.substring(currentIndex)));
  }

  return spans;
}
