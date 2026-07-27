import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/utils/inline_style_parser.dart';

TextSpan _span(List<InlineSpan> spans, int index) => spans[index] as TextSpan;

void main() {
  group('parseInlineStyles', () {
    group('plain text', () {
      test('returns empty list for empty string', () {
        expect(parseInlineStyles(''), isEmpty);
      });

      test('returns single unstyled span', () {
        final result = parseInlineStyles('hello world');
        expect(result.length, 1);
        expect(_span(result, 0).text, 'hello world');
        expect(_span(result, 0).style, isNull);
      });

      test('hyphenated words are not matched as strikethrough', () {
        final result = parseInlineStyles('all-in-one');
        expect(result.length, 1);
        expect(_span(result, 0).text, 'all-in-one');
        expect(_span(result, 0).style, isNull);
      });
    });

    group('bold *text*', () {
      test('applies bold style', () {
        final result = parseInlineStyles('*bold*');
        expect(result.length, 1);
        expect(_span(result, 0).style?.fontWeight, FontWeight.bold);
        expect((_span(result, 0).children![0] as TextSpan).text, 'bold');
      });

      test('preserves surrounding plain text', () {
        final result = parseInlineStyles('hello *world* there');
        expect(result.length, 3);
        expect(_span(result, 0).text, 'hello ');
        expect(_span(result, 1).style?.fontWeight, FontWeight.bold);
        expect(_span(result, 2).text, ' there');
      });

      test('handles multiple bold spans', () {
        final result = parseInlineStyles('*one* and *two*');
        expect(result.length, 3);
        expect(_span(result, 0).style?.fontWeight, FontWeight.bold);
        expect(_span(result, 1).text, ' and ');
        expect(_span(result, 2).style?.fontWeight, FontWeight.bold);
      });

      test('unmatched * is plain text', () {
        final result = parseInlineStyles('*no close');
        expect(result.length, 1);
        expect(_span(result, 0).text, '*no close');
      });
    });

    group('italic _text_', () {
      test('applies italic style', () {
        final result = parseInlineStyles('_italic_');
        expect(result.length, 1);
        expect(_span(result, 0).style?.fontStyle, FontStyle.italic);
        expect((_span(result, 0).children![0] as TextSpan).text, 'italic');
      });

      test('preserves surrounding plain text', () {
        final result = parseInlineStyles('hello _world_ there');
        expect(result.length, 3);
        expect(_span(result, 0).text, 'hello ');
        expect(_span(result, 1).style?.fontStyle, FontStyle.italic);
        expect(_span(result, 2).text, ' there');
      });

      test('unmatched _ is plain text', () {
        final result = parseInlineStyles('_no close');
        expect(result.length, 1);
        expect(_span(result, 0).text, '_no close');
      });
    });

    group('strikethrough ~~text~~', () {
      test('applies lineThrough decoration', () {
        final result = parseInlineStyles('~~strike~~');
        expect(result.length, 1);
        expect(_span(result, 0).style?.decoration, TextDecoration.lineThrough);
        expect((_span(result, 0).children![0] as TextSpan).text, 'strike');
      });

      test('preserves surrounding plain text', () {
        final result = parseInlineStyles('hello ~~world~~ there');
        expect(result.length, 3);
        expect(_span(result, 0).text, 'hello ');
        expect(_span(result, 1).style?.decoration, TextDecoration.lineThrough);
        expect(_span(result, 2).text, ' there');
      });

      test('unmatched ~~ is plain text', () {
        final result = parseInlineStyles('~~no close');
        expect(result.length, 1);
        expect(_span(result, 0).text, '~~no close');
      });
    });

    group('nesting', () {
      test('italic inside bold', () {
        final result = parseInlineStyles('*bold _italic_ end*');
        expect(result.length, 1);

        final outer = _span(result, 0);
        expect(outer.style?.fontWeight, FontWeight.bold);
        expect(outer.children?.length, 3);

        expect((_span(outer.children!, 0)).text, 'bold ');

        final inner = _span(outer.children!, 1);
        expect(inner.style?.fontStyle, FontStyle.italic);
        expect((_span(inner.children!, 0)).text, 'italic');

        expect((_span(outer.children!, 2)).text, ' end');
      });

      test('bold inside italic', () {
        final result = parseInlineStyles('_italic *bold* end_');
        expect(result.length, 1);

        final outer = _span(result, 0);
        expect(outer.style?.fontStyle, FontStyle.italic);

        final inner = _span(outer.children!, 1);
        expect(inner.style?.fontWeight, FontWeight.bold);
        expect((_span(inner.children!, 0)).text, 'bold');
      });

      test('bold inside strikethrough', () {
        final result = parseInlineStyles('~~strike *bold* end~~');
        expect(result.length, 1);

        final outer = _span(result, 0);
        expect(outer.style?.decoration, TextDecoration.lineThrough);

        final inner = _span(outer.children!, 1);
        expect(inner.style?.fontWeight, FontWeight.bold);
        expect((_span(inner.children!, 0)).text, 'bold');
      });

      test('italic inside strikethrough', () {
        final result = parseInlineStyles('~~strike _italic_ end~~');
        expect(result.length, 1);

        final outer = _span(result, 0);
        expect(outer.style?.decoration, TextDecoration.lineThrough);

        final inner = _span(outer.children!, 1);
        expect(inner.style?.fontStyle, FontStyle.italic);
      });

      test('strikethrough inside bold', () {
        final result = parseInlineStyles('*bold ~~strike~~ end*');
        expect(result.length, 1);

        final outer = _span(result, 0);
        expect(outer.style?.fontWeight, FontWeight.bold);

        final inner = _span(outer.children!, 1);
        expect(inner.style?.decoration, TextDecoration.lineThrough);
      });
    });

    group('mixed styles in sequence', () {
      test('bold then italic', () {
        final result = parseInlineStyles('*bold* and _italic_');
        expect(result.length, 3);
        expect(_span(result, 0).style?.fontWeight, FontWeight.bold);
        expect(_span(result, 1).text, ' and ');
        expect(_span(result, 2).style?.fontStyle, FontStyle.italic);
      });

      test('all three styles in sequence', () {
        final result = parseInlineStyles('*bold* _italic_ ~~strike~~');
        expect(result.length, 5);
        expect(_span(result, 0).style?.fontWeight, FontWeight.bold);
        expect(_span(result, 1).text, ' ');
        expect(_span(result, 2).style?.fontStyle, FontStyle.italic);
        expect(_span(result, 3).text, ' ');
        expect(_span(result, 4).style?.decoration, TextDecoration.lineThrough);
      });
    });

    group('escape sequences', () {
      test(r'\* renders as literal asterisk', () {
        final result = parseInlineStyles(r'\*not bold\*');
        expect(result.length, 1);
        expect(_span(result, 0).text, '*not bold*');
        expect(_span(result, 0).style, isNull);
      });

      test(r'\_ renders as literal underscore', () {
        final result = parseInlineStyles(r'\_not italic\_');
        expect(result.length, 1);
        expect(_span(result, 0).text, '_not italic_');
        expect(_span(result, 0).style, isNull);
      });

      test(r'\~\~ renders as literal tildes', () {
        final result = parseInlineStyles(r'\~\~not strike\~\~');
        expect(result.length, 1);
        expect(_span(result, 0).text, '~~not strike~~');
        expect(_span(result, 0).style, isNull);
      });
    });
  });
}
