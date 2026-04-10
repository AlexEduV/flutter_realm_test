import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/extensions/text_style_extension.dart';

void main() {
  group('WhitenTextStyle', () {
    test('whiten returns a new TextStyle with color set to Colors.white', () {
      const original = TextStyle(fontSize: 16, color: Colors.black);
      final whitened = original.whiten();

      expect(whitened.color, Colors.white);
      expect(whitened.fontSize, original.fontSize);
      // Optionally, check that other properties are unchanged
    });

    test('whiten overrides existing color', () {
      const original = TextStyle(color: Colors.red);
      final whitened = original.whiten();

      expect(whitened.color, Colors.white);
    });

    test('whiten sets color to white if original color is null', () {
      const original = TextStyle();
      final whitened = original.whiten();

      expect(whitened.color, Colors.white);
    });
  });
}
