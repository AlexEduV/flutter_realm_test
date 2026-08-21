import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/widgets/network_error_widget.dart';

import '../../common/fakes/image_fakes.dart';

void main() {
  late AppLocalisationsCubit appLocalisationsCubit;

  setUp(() {
    appLocalisationsCubit = AppLocalisationsCubit();
    appLocalisationsCubit.load({
      L10nKeys.noContentWidgetTitle: 'Content not available',
      L10nKeys.noContentWidgetSubtitle: 'Please check your internet connection',
    });
  });

  Widget buildWidget() {
    return DefaultAssetBundle(
      bundle: FakeAssetBundle(),
      child: BlocProvider<AppLocalisationsCubit>.value(
        value: appLocalisationsCubit,
        child: const MaterialApp(
          home: Scaffold(body: NetworkErrorWidget()),
        ),
      ),
    );
  }

  group('NetworkErrorWidget', () {
    testWidgets('renders title text from localisation', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      expect(find.text('Content not available'), findsOneWidget);
    });

    testWidgets('renders subtitle text from localisation', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      expect(find.text('Please check your internet connection'), findsOneWidget);
    });

    testWidgets('renders background image', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('applies ClipRRect with rounded corners', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      expect(find.byType(ClipRRect), findsOneWidget);
    });

    testWidgets('title uses white bold text style', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      final titleWidget = tester.widget<Text>(find.text('Content not available'));
      expect(titleWidget.style?.color, Colors.white);
      expect(titleWidget.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('subtitle uses white text style', (tester) async {
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      final subtitleWidget = tester.widget<Text>(
        find.text('Please check your internet connection'),
      );
      expect(subtitleWidget.style?.color, Colors.white);
    });

    testWidgets('shows empty strings when localisations are not loaded', (tester) async {
      appLocalisationsCubit.clear();
      await tester.pumpWidget(buildWidget());
      await tester.pump();

      // context.tr() falls back to empty string for unknown keys
      final texts = tester.widgetList<Text>(find.byType(Text)).toList();
      expect(texts.every((t) => t.data == '' || t.data == null), isTrue);
    });
  });
}
