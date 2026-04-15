import 'package:intl/intl.dart';
import 'package:test_flutter_project/common/extensions/string_extension.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';

class DateFormatter {
  static String formatSmartDate(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateDay = DateTime(date.year, date.month, date.day);

    if (dateDay == today) {
      // Today: show time
      return DateFormat.Hm().format(date); // e.g., "14:23"
    } else if (dateDay == today.subtract(const Duration(days: 1))) {
      // Yesterday
      return serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
        L10nKeys.dateFormattingYesterday,
      );
    } else {
      final locale = serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(L10nKeys.locale);

      // Day of the week shortened, e.g. "Mon"
      return DateFormat.E(locale).format(date).capitalizeFirst();
    }
  }

  static String formatMessageDividerDate(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateDay = DateTime(date.year, date.month, date.day);

    if (dateDay == today) {
      // Today
      return serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
        L10nKeys.dateFormattingToday,
      );
    } else if (dateDay == today.subtract(const Duration(days: 1))) {
      // Yesterday
      return serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
        L10nKeys.dateFormattingYesterday,
      );
    } else {
      final locale = serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(L10nKeys.locale);
      final isThisYear = date.year == now.year;

      if (isThisYear) {
        // Example: March 16
        return DateFormat('MMMM d', locale).format(date);
      } else {
        // Example: March 16, 2015
        return DateFormat('MMMM d, y', locale).format(date);
      }
    }
  }
}
