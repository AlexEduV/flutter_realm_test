import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetAllCarsUseCase implements UseCase<List<CarEntity>, void> {
  GetAllCarsUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  List<CarEntity> call(void params) {
    return _carRepository.getAllCars();
  }
}
