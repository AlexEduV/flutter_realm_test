import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bottom_bar_state.freezed.dart';

@freezed
abstract class HomeBottomBarState with _$HomeBottomBarState {
  const factory HomeBottomBarState({@Default(0) int currentSelectedTabIndex}) = _HomeBottomBarState;
}
