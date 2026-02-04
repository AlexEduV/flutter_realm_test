import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class WatchCarsUseCase implements UseCase<Stream<List<CarEntity>>?, void> {
  WatchCarsUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  Future<Stream<List<CarEntity>>?> call(void params) async {
    return _carRepository.watchCars();
  }
}
