import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

void main() {
  group('AppSemantics', () {
    testWidgets('renders child and sets label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppSemantics(label: 'Test Label', child: Text('Child Widget')),
        ),
      );

      expect(find.text('Child Widget'), findsOneWidget);

      // Check semantics label
      final semantics = tester.getSemantics(find.byType(AppSemantics));
      expect(semantics.label.contains('Test Label'), isTrue);
    });

    testWidgets('sets all semantics properties', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppSemantics(
            label: 'Button Label',
            button: true,
            enabled: true,
            isSelected: true,
            isChecked: true,
            textField: true,
            expanded: true,
            child: Text('Button Child'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(AppSemantics));
      expect(semantics.label.contains('Button Label'), isTrue);
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isEnabled, Tristate.isTrue);
      expect(semantics.flagsCollection.isSelected, Tristate.isTrue);
      expect(semantics.flagsCollection.isChecked, CheckedState.isTrue);
      expect(semantics.flagsCollection.isTextField, isTrue);
      expect(semantics.flagsCollection.isExpanded, Tristate.isTrue);
    });

    testWidgets('sets only provided semantics properties', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppSemantics(
            label: 'Partial Label',
            button: true,
            isSelected: false,
            child: Text('Partial Child'),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(AppSemantics));
      expect(semantics.label.contains('Partial Label'), isTrue);
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isSelected, Tristate.isFalse);
    });
  });
}
