import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class AddCarUseCase implements UseCaseWithParams<CarEntity, void> {
  AddCarUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  void call(CarEntity params) {
    return _carRepository.addCar(params);
  }
}
