import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

part 'home_page_state.freezed.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const factory HomePageState({@Default([]) List<CarEntity> cars, @Default(false) bool isLoading}) =
      _HomePageState;
}
