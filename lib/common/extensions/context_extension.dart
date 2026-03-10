import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/bloc/l10n/app_localisations_cubit.dart';

extension L10nX on BuildContext {
  //most use cases
  String tr(String key) => watch<AppLocalisationsCubit>().state.get(key);

  //in the callbacks, listeners are not allowed
  String trRead(String key) => read<AppLocalisationsCubit>().state.get(key);
}
