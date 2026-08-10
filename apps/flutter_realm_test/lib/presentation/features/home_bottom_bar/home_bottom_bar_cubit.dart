import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_bottom_bar_state.dart';

class HomeBottomBarCubit extends Cubit<HomeBottomBarState> {
  HomeBottomBarCubit() : super(const HomeBottomBarState());

  void updateSelectedIndex(int newIndex) {
    emit(state.copyWith(currentSelectedTabIndex: newIndex));
  }
}
