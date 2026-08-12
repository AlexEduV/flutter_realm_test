import 'package:intl/intl.dart';
import 'package:test_flutter_project/common/extensions/string_extension.dart';
import 'package:test_flutter_project/domain/services/time_service.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';

typedef _NormalizedDates = ({DateTime today, DateTime dateDay, DateTime yesterday});

class DateFormatter {
  DateFormatter(this._appLocalisationsCubit, this._timeService);

  final AppLocalisationsCubit _appLocalisationsCubit;
  final TimeService _timeService;

  _NormalizedDates _normalizeDates(DateTime date) {
    final now = _timeService.now();
    return (
      today: DateTime(now.year, now.month, now.day),
      dateDay: DateTime(date.year, date.month, date.day),
      yesterday: DateTime(now.year, now.month, now.day - 1),
    );
  }

  String formatSmartDate(DateTime? date) {
    if (date == null) return '';

    final dates = _normalizeDates(date);

    if (dates.dateDay == dates.today) {
      // Today: show time
      return DateFormat.Hm().format(date); // e.g., "14:23"
    } else if (dates.dateDay == dates.yesterday) {
      // Yesterday
      return _appLocalisationsCubit.getLocalisationByKey(L10nKeys.dateFormattingYesterday);
    } else {
      final locale = _appLocalisationsCubit.getLocalisationByKey(L10nKeys.locale);

      // Day of the week shortened, e.g. "Mon"
      return DateFormat.E(locale).format(date).capitalizeFirst();
    }
  }

  String formatMessageDividerDate(DateTime? date) {
    if (date == null) return '';

    final dates = _normalizeDates(date);

    if (dates.dateDay == dates.today) {
      // Today
      return _appLocalisationsCubit.getLocalisationByKey(L10nKeys.dateFormattingToday);
    } else if (dates.dateDay == dates.yesterday) {
      // Yesterday
      return _appLocalisationsCubit.getLocalisationByKey(L10nKeys.dateFormattingYesterday);
    } else {
      final locale = _appLocalisationsCubit.getLocalisationByKey(L10nKeys.locale);
      final isThisYear = date.year == dates.today.year;

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
