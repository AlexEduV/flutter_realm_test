import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/home_bottom_bar/home_bottom_bar_state.dart';

void main() {
  group('HomeBottomBarCubit', () {
    test('initial state is HomeBottomBarState with currentSelectedTabIndex 0', () {
      final cubit = HomeBottomBarCubit();
      expect(cubit.state, const HomeBottomBarState());
      expect(cubit.state.currentSelectedTabIndex, 0);
    });

    blocTest<HomeBottomBarCubit, HomeBottomBarState>(
      'emits state with updated currentSelectedTabIndex when updateSelectedIndex is called',
      build: () => HomeBottomBarCubit(),
      act: (cubit) => cubit.updateSelectedIndex(2),
      expect: () => [const HomeBottomBarState(currentSelectedTabIndex: 2)],
    );

    blocTest<HomeBottomBarCubit, HomeBottomBarState>(
      'emits correct states for multiple index updates',
      build: () => HomeBottomBarCubit(),
      act: (cubit) {
        cubit.updateSelectedIndex(1);
        cubit.updateSelectedIndex(3);
      },
      expect: () => [
        const HomeBottomBarState(currentSelectedTabIndex: 1),
        const HomeBottomBarState(currentSelectedTabIndex: 3),
      ],
    );
  });
}
