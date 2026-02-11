import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetCurrentMaxCarIdUseCase implements UseCaseNoParams<int> {
  GetCurrentMaxCarIdUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  int call() {
    return _carRepository.getMaxCarId();
  }
}
