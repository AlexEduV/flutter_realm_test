import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_dimensions.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/home/home_bottom_bar/home_bottom_bar.dart';
import 'package:test_flutter_project/presentation/pages/home/home_bottom_bar/widgets/home_bottom_bar_item.dart';

import '../../../../utils/app_router_test.mocks.dart';

void main() {
  final mockHomeBottomBarCubit = MockHomeBottomBarCubit();
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    final localisations = {'actions.addCar.tooltip': 'Add a car'};
    appLocalisationsCubit.load(localisations);

    serviceLocator.registerLazySingleton<AppLocalisationsCubit>(() => appLocalisationsCubit);

    when(
      mockHomeBottomBarCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeBottomBarState()]));

    when(mockHomeBottomBarCubit.state).thenReturn(const HomeBottomBarState());
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  group('HomeBottomBar', () {
    testWidgets('displays all HomeBottomBarItems and add button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<HomeBottomBarCubit>.value(value: mockHomeBottomBarCubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: MaterialApp(
            home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
          ),
        ),
      );

      expect(find.byType(HomeBottomBarItem), findsNWidgets(4));
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('calls onAddPressed when add button is tapped', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<HomeBottomBarCubit>.value(value: mockHomeBottomBarCubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: MaterialApp(
            home: Scaffold(
              bottomNavigationBar: HomeBottomBar(
                onAddPressed: () {
                  pressed = true;
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      expect(pressed, isTrue);
    });

    testWidgets('add button has correct style and tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<HomeBottomBarCubit>.value(value: mockHomeBottomBarCubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: MaterialApp(
            home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
          ),
        ),
      );

      final iconButton = tester.widget<InkWell>(find.widgetWithIcon(InkWell, Icons.add));

      expect(iconButton.splashColor, AppColors.accentColor.withAlpha(60));
      expect(iconButton.highlightColor, Colors.transparent);
    });

    testWidgets('container has correct decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<HomeBottomBarCubit>.value(value: mockHomeBottomBarCubit),
            BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          ],
          child: MaterialApp(
            home: Scaffold(bottomNavigationBar: HomeBottomBar(onAddPressed: () {})),
          ),
        ),
      );

      final decoratedBox = tester.widget<DecoratedBox>(
        find.descendant(of: find.byType(HomeBottomBar), matching: find.byType(DecoratedBox).first),
      );

      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.color, Colors.white);
      expect(
        decoration.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.normalL),
          topRight: Radius.circular(AppDimensions.normalL),
        ),
      );
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.first.color, Colors.grey.withAlpha(60));
    });
  });
}
