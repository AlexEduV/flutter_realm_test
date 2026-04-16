import 'package:test_flutter_project/l10n/l10n_keys.dart';

import '../../core/di/injection_container.dart';
import '../../presentation/bloc/l10n/app_localisations_cubit.dart';

enum TransmissionType {
  manual(L10nKeys.transmissionTypeManual),
  automatic(L10nKeys.transmissionTypeAutomatic),
  hybrid(L10nKeys.transmissionTypeHybrid);

  final String localisationKey;

  const TransmissionType(this.localisationKey);

  String fromLocalisations() {
    final localisation = serviceLocator<AppLocalisationsCubit>().getLocalisationByKey(
      localisationKey,
    );
    return localisation;
  }
}
