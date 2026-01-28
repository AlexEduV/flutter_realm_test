import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  group('AppLocalisations', () {
    test('results string is correct', () {
      expect(AppLocalisations.results, 'Results');
    });

    test('addCarButtonTooltip string is correct', () {
      expect(AppLocalisations.addCarButtonTooltip, 'Add a car');
    });

    test('deleteButtonTitle string is correct', () {
      expect(AppLocalisations.deleteButtonTitle, 'Delete');
    });

    test('distanceWidgetText string is correct', () {
      expect(AppLocalisations.distanceWidgetText, 'km away');
    });
  });
}
