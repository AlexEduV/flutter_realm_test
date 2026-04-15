import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/constants/app_text_styles.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/home/widgets/placeholder_page.dart';

void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);

    // Set up localisation values for the test
    final localisations = {
      'pages.comingSoon.title': 'Coming Soon',
      'pages.comingSoon.subtitle': 'This feature is not available yet.',
    };

    appLocalisationsCubit.load(localisations);
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  group('PlaceholderPage', () {
    testWidgets('displays the hourglass icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit)],
          child: const MaterialApp(home: PlaceholderPage()),
        ),
      );

      final iconFinder = find.byIcon(Icons.hourglass_empty);
      expect(iconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.size, AppDimensions.placeholderPageIconSize);
      expect(iconWidget.color, Colors.grey);
    });

    testWidgets('displays the correct title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit)],
          child: const MaterialApp(home: PlaceholderPage()),
        ),
      );

      expect(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(L10nKeys.comingSoonPlaceholderPageTitle),
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(L10nKeys.comingSoonPlaceholderPageSubTitle),
        ),
        findsOneWidget,
      );
    });

    testWidgets('uses correct text styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit)],
          child: const MaterialApp(home: PlaceholderPage()),
        ),
      );

      final titleText = tester.widget<Text>(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(L10nKeys.comingSoonPlaceholderPageTitle),
        ),
      );
      expect(titleText.style?.fontSize, AppTextStyles.zonaPro24.fontSize);
      expect(titleText.style?.fontWeight, AppTextStyles.zonaPro24.fontWeight);

      final subtitleText = tester.widget<Text>(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(L10nKeys.comingSoonPlaceholderPageSubTitle),
        ),
      );
      expect(subtitleText.style?.fontSize, AppTextStyles.zonaPro16.fontSize);
      expect(subtitleText.style?.fontWeight, AppTextStyles.zonaPro16.fontWeight);
      expect(subtitleText.style?.color, Colors.grey);
      expect(subtitleText.textAlign, TextAlign.center);
    });

    testWidgets('has correct background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit)],
          child: const MaterialApp(home: PlaceholderPage()),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, AppColors.scaffoldColor);
    });
  });
}
