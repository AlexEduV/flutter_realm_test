import 'package:flutter/cupertino.dart';

class InlineStyleTextController extends TextEditingController {
  InlineStyleTextController({super.text});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    required bool withComposing,
    TextStyle? style,
  }) {
    return TextSpan(style: style, children: _parseText(text));
  }

  List<TextSpan> _parseText(String text) {
    final spans = <TextSpan>[];

    final regex = RegExp(r'(_[^_]+_|-[^-]+-|\*[^*]+\*)');
    final matches = regex.allMatches(text);

    int currentIndex = 0;

    for (final match in matches) {
      // Normal text before match
      if (match.start > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
      }

      final matchedText = match.group(0)!;
      final content = matchedText.substring(1, matchedText.length - 1);

      TextStyle styledText;

      if (matchedText.startsWith('_')) {
        styledText = const TextStyle(fontStyle: FontStyle.italic);
      } else if (matchedText.startsWith('-')) {
        styledText = const TextStyle(decoration: TextDecoration.lineThrough);
      } else {
        styledText = const TextStyle(fontWeight: FontWeight.bold);
      }

      spans.add(TextSpan(text: content, style: styledText));

      currentIndex = match.end;
    }

    // Remaining text
    if (currentIndex < text.length) {
      spans.add(TextSpan(text: text.substring(currentIndex)));
    }

    return spans;
  }
}
