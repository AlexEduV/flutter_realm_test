import '../../core/di/injection_container.dart';
import '../../presentation/features/l10n/app_localisations_cubit.dart';
import '../../presentation/features/search/search_page_identifiers.dart';

enum TransmissionType {
  manual(SearchPageLocaleKeys.transmissionTypeManual),
  automatic(SearchPageLocaleKeys.transmissionTypeAutomatic),
  hybrid(SearchPageLocaleKeys.transmissionTypeHybrid);

  const TransmissionType(this.localisationKey);

  final String localisationKey;

  String fromLocalisations() {
    final localisation = serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
      localisationKey,
    );
    return localisation;
  }
}
