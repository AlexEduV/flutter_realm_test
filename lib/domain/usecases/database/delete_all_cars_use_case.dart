import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class DeleteAllCarsUseCase implements UseCaseNoParams<void> {
  DeleteAllCarsUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  Future<void> call() async {
    return _carRepository.deleteAll();
  }
}
