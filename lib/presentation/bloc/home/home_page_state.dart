import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({@Default([]) List<CarEntity> cars, @Default(false) bool isLoading}) =
      _HomePageState;

  //todo: overrides seem redundant with annotations present
  @override
  List<CarEntity> get cars => [];

  @override
  bool get isLoading => false;
}
