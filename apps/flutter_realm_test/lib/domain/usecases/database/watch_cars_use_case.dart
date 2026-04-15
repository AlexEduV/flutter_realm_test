import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class WatchCarsUseCase implements UseCaseNoParams<Stream<List<CarEntity>>?> {
  WatchCarsUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  Stream<List<CarEntity>>? call() {
    return _carRepository.watchCars();
  }
}
