import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:test_futter_project/utils/date_formatter.dart';

void main() {
  group('DateFormatter.formatSmartDate', () {
    test('returns time for today\'s date', () {
      final now = DateTime.now();
      final formatted = DateFormatter.formatSmartDate(now);
      // Should match HH:mm format
      final expected = DateFormat.Hm().format(now);
      expect(formatted, expected);
    });

    test('returns "Yesterday" for yesterday\'s date', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final formatted = DateFormatter.formatSmartDate(yesterday);
      expect(formatted, 'Yesterday');
    });

    test('returns weekday for other dates', () {
      // Pick a date 2 days ago
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
      final formatted = DateFormatter.formatSmartDate(twoDaysAgo);
      final expected = DateFormat.EEEE().format(twoDaysAgo);
      expect(formatted, expected);
    });

    test('returns weekday for a date in the future', () {
      final futureDate = DateTime.now().add(const Duration(days: 3));
      final formatted = DateFormatter.formatSmartDate(futureDate);
      final expected = DateFormat.EEEE().format(futureDate);
      expect(formatted, expected);
    });
  });
}
