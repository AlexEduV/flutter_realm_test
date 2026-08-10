import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/search/search_page_identifiers.dart';

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
              text: appLocalisationsCubit.getLocalisationByKey(
                SearchPageLocaleKeys.emptySearchPlaceholderText,
              ),
            ),
          ),
        ),
      );

      expect(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(
            SearchPageLocaleKeys.emptySearchPlaceholderText,
          ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('uses correct text style and maxLines', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyResultsPlaceholderWidget(
              text: appLocalisationsCubit.getLocalisationByKey(
                SearchPageLocaleKeys.emptySearchPlaceholderText,
              ),
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(
            SearchPageLocaleKeys.emptySearchPlaceholderText,
          ),
        ),
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
              text: appLocalisationsCubit.getLocalisationByKey(
                SearchPageLocaleKeys.emptySearchPlaceholderText,
              ),
            ),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(find.byType(Padding));
      expect(paddingWidget.padding, const EdgeInsets.all(AppDimensions.normalL));
    });

    testWidgets('text is a direct child of padding with ellipsis overflow', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyResultsPlaceholderWidget(
              text: appLocalisationsCubit.getLocalisationByKey(
                SearchPageLocaleKeys.emptySearchPlaceholderText,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Row), findsNothing);
      expect(find.byType(Flexible), findsNothing);

      final textWidget = tester.widget<Text>(
        find.text(
          appLocalisationsCubit.getLocalisationByKey(
            SearchPageLocaleKeys.emptySearchPlaceholderText,
          ),
        ),
      );
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
