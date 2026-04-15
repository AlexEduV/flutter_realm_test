import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class DeleteAllCarsUseCase implements UseCaseNoParams<void> {
  DeleteAllCarsUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  void call() {
    return _carRepository.deleteAll();
  }
}
