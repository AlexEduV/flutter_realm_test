import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/common/constants/app_text_styles.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/search/widgets/empty_search_placeholder_widget.dart';

void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);

    // Set up localisation values for the test
    final localisations = {
      'pages.search.emptyPlaceholder': 'No results were found for this search.',
    };

    appLocalisationsCubit.load(localisations);
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  group('EmptySearchPlaceholderWidget', () {
    testWidgets('displays the correct placeholder text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyResultsPlaceholderWidget(
              text: appLocalisationsCubit.getLocalisationByKey(L10nKeys.emptySearchPlaceholderText),
            ),
          ),
        ),
      );

      expect(
        find.text(appLocalisationsCubit.getLocalisationByKey(L10nKeys.emptySearchPlaceholderText)),
        findsOneWidget,
      );
    });

    testWidgets('uses correct text style and maxLines', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyResultsPlaceholderWidget(
              text: appLocalisationsCubit.getLocalisationByKey(L10nKeys.emptySearchPlaceholderText),
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(
        find.text(appLocalisationsCubit.getLocalisationByKey(L10nKeys.emptySearchPlaceholderText)),
      );
      expect(textWidget.style?.fontSize, AppTextStyles.zonaPro18.fontSize);
      expect(textWidget.style?.fontWeight, AppTextStyles.zonaPro18.fontWeight);
      expect(textWidget.maxLines, 3);
    });

    testWidgets('applies correct padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyResultsPlaceholderWidget(
              text: appLocalisationsCubit.getLocalisationByKey(L10nKeys.emptySearchPlaceholderText),
            ),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(find.byType(Padding));
      expect(paddingWidget.padding, const EdgeInsets.all(AppDimensions.normalL));
    });

    testWidgets('uses Flexible inside Row', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyResultsPlaceholderWidget(
              text: appLocalisationsCubit.getLocalisationByKey(L10nKeys.emptySearchPlaceholderText),
            ),
          ),
        ),
      );

      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      final flexibleFinder = find.descendant(of: rowFinder, matching: find.byType(Flexible));
      expect(flexibleFinder, findsOneWidget);
    });
  });
}
