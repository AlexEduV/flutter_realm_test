import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/results_widget.dart';
import 'package:widgetbook/widgetbook.dart';

export '';

Widget buildResultsWidgetUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({L10nKeys.results: 'Results'});

  return MultiBlocProvider(
    providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
    child: Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: Column(
        spacing: AppDimensions.normalL,
        children: [
          ResultsWidget(
            resultsCount: context.knobs.int
                .input(label: 'Results count', initialValue: 0)
                .toString(),
          ),
        ],
      ),
    ),
  );
}
