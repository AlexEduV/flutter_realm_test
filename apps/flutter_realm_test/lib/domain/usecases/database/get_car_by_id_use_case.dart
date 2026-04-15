import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetCarByIdUseCase implements UseCaseWithParams<String, CarEntity> {
  GetCarByIdUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  CarEntity call(String params) {
    return _carRepository.getCarById(params);
  }
}
