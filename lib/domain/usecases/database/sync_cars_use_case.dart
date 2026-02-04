import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class SyncCarsUseCase implements UseCase<void, void> {
  SyncCarsUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  Future<void> call(void params) async {
    return _carRepository.syncCars();
  }
}
