import 'package:flutter/widgets.dart'
    show FontStyle, FontWeight, InlineSpan, TextDecoration, TextSpan, TextStyle;

/// Parses a string with inline markdown-lite markers into styled [InlineSpan]s.
/// Supports `_italic_`, `~~strikethrough~~`, `*bold*`, nesting, and `\` escapes.
List<InlineSpan> parseInlineStyles(String text) => _parse(text);

List<InlineSpan> _parse(String text) {
  final spans = <InlineSpan>[];
  final buffer = StringBuffer();
  var i = 0;

  void flush() {
    if (buffer.isNotEmpty) {
      spans.add(TextSpan(text: buffer.toString()));
      buffer.clear();
    }
  }

  while (i < text.length) {
    final ch = text[i];

    if (ch == '\\' && i + 1 < text.length) {
      buffer.write(text[i + 1]);
      i += 2;
      continue;
    }

    if (ch == '~' && i + 1 < text.length && text[i + 1] == '~') {
      final close = text.indexOf('~~', i + 2);
      if (close != -1) {
        flush();
        spans.add(
          TextSpan(
            style: const TextStyle(decoration: TextDecoration.lineThrough),
            children: _parse(text.substring(i + 2, close)),
          ),
        );
        i = close + 2;
        continue;
      }
    }

    if (ch == '*') {
      final close = text.indexOf('*', i + 1);
      if (close != -1) {
        flush();
        spans.add(
          TextSpan(
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: _parse(text.substring(i + 1, close)),
          ),
        );
        i = close + 1;
        continue;
      }
    }

    if (ch == '_') {
      final close = text.indexOf('_', i + 1);
      if (close != -1) {
        flush();
        spans.add(
          TextSpan(
            style: const TextStyle(fontStyle: FontStyle.italic),
            children: _parse(text.substring(i + 1, close)),
          ),
        );
        i = close + 1;
        continue;
      }
    }

    buffer.write(ch);
    i++;
  }

  flush();
  return spans;
}
