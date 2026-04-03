import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test_futter_project/core/di/injection_container.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/utils/date_formatter.dart';

void main() {
  initializeDateFormatting('en');

  final appLocalisationsCubit = AppLocalisationsCubit();
  final localisations = {
    'app.locale': 'en',
    'dateFormatting.yesterday': 'Yesterday',
    'dateFormatting.today': 'Today',
  };

  appLocalisationsCubit.load(localisations);

  setUpAll(() {
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);
  });

  tearDownAll(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  group('DateFormatter.formatSmartDate', () {
    test('returns time for today\'s date', () {
      final now = DateTime.now();
      final formatted = DateFormatter.formatSmartDate(now);
      final expected = DateFormat.Hm().format(now);
      expect(formatted, expected);
    });

    test('returns "Yesterday" for yesterday\'s date', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final formatted = DateFormatter.formatSmartDate(yesterday);
      expect(formatted, 'Yesterday');
    });

    test('returns weekday for other dates', () {
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));
      final formatted = DateFormatter.formatSmartDate(twoDaysAgo);
      final expected =
          DateFormat.E('en').format(twoDaysAgo)[0].toUpperCase() +
          DateFormat.E('en').format(twoDaysAgo).substring(1);
      expect(formatted, expected);
    });

    test('returns weekday for a date in the future', () {
      final futureDate = DateTime.now().add(const Duration(days: 3));
      final formatted = DateFormatter.formatSmartDate(futureDate);
      final expected =
          DateFormat.E('en').format(futureDate)[0].toUpperCase() +
          DateFormat.E('en').format(futureDate).substring(1);
      expect(formatted, expected);
    });

    test('returns empty string for null date', () {
      expect(DateFormatter.formatSmartDate(null), '');
    });
  });

  group('DateFormatter.formatMessageDividerDate', () {
    test('returns "Today" for today\'s date', () {
      final now = DateTime.now();
      final formatted = DateFormatter.formatMessageDividerDate(now);
      expect(formatted, 'Today');
    });

    test('returns "Yesterday" for yesterday\'s date', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final formatted = DateFormatter.formatMessageDividerDate(yesterday);
      expect(formatted, 'Yesterday');
    });

    test('returns "March 16" for a date this year', () {
      final date = DateTime(DateTime.now().year, 3, 16);
      final formatted = DateFormatter.formatMessageDividerDate(date);
      final expected = DateFormat('MMMM d', 'en').format(date);
      expect(formatted, expected);
    });

    test('returns "March 16, 2015" for a date in a previous year', () {
      final date = DateTime(2015, 3, 16);
      final formatted = DateFormatter.formatMessageDividerDate(date);
      final expected = DateFormat('MMMM d, y', 'en').format(date);
      expect(formatted, expected);
    });

    test('returns empty string for null date', () {
      expect(DateFormatter.formatMessageDividerDate(null), '');
    });
  });
}
