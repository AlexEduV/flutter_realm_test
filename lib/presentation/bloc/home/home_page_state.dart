import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/scheme.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({@Default([]) List<Car> cars}) = _HomePageState;

  @override
  List<Car> get cars => [];
}
