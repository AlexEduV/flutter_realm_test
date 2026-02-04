import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class WatchCarsUseCase implements UseCase<Stream<List<CarEntity>>?, void> {
  WatchCarsUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  Stream<List<CarEntity>>? call(void params) {
    return _carRepository.watchCars();
  }
}
