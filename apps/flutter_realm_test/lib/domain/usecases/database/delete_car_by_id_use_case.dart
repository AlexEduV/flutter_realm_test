import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class DeleteCarByIdUseCase implements UseCaseWithParams<String, void> {
  DeleteCarByIdUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  void call(String params) {
    return _carRepository.deleteCarById(params);
  }
}
