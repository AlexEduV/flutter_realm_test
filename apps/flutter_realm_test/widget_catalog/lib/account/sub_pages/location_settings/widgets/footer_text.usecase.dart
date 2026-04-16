import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/account/sub_pages/location_settings/widgets/footer_text.dart';
import 'package:widgetbook/widgetbook.dart';

Widget buildFooterTextUseCase(BuildContext context) {
  final appLocalisationsCubit = AppLocalisationsCubit()..load({});

  return Scaffold(
    backgroundColor: AppColors.scaffoldColor,
    body: Padding(
      padding: const EdgeInsets.all(AppDimensions.normalM),
      child: MultiBlocProvider(
        providers: [BlocProvider<AppLocalisationsCubit>(create: (_) => appLocalisationsCubit)],
        child: Row(
          children: [
            FooterText(
              text: context.knobs.string(label: 'Label', initialValue: 'Footer link'),
              url: context.knobs.boolean(label: 'Is url empty', initialValue: false)
                  ? null
                  : 'https://google.com',
            ),
          ],
        ),
      ),
    ),
  );
}
