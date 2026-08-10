import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';

import '../../core/di/injection_container.dart';
import '../../presentation/features/l10n/app_localisations_cubit.dart';

enum TransmissionType {
  manual(L10nKeys.transmissionTypeManual),
  automatic(L10nKeys.transmissionTypeAutomatic),
  hybrid(L10nKeys.transmissionTypeHybrid);

  const TransmissionType(this.localisationKey);

  final String localisationKey;

  String fromLocalisations() {
    final localisation = serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
      localisationKey,
    );
    return localisation;
  }
}
