import 'package:intl/intl.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';
import 'package:test_futter_project/utils/l10n.dart';

class DateFormatter {
  static String formatSmartDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateDay = DateTime(date.year, date.month, date.day);

    if (dateDay == today) {
      // Today: show time
      return DateFormat.Hm().format(date); // e.g., "14:23"
    } else if (dateDay == today.subtract(const Duration(days: 1))) {
      // Yesterday
      return AppLocalisations.dateFormattingYesterday;
    } else {
      // Day of the week
      return DateFormat.EEEE(
        AppLocalisations.locale,
      ).format(date).capitalizeFirst(); // e.g., "Monday"
    }
  }
}
