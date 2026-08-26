import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetCarByIdUseCase implements UseCaseWithParams<String, CarEntity?> {
  GetCarByIdUseCase(this._loggingService, this._carRepository);

  final LoggingService _loggingService;
  final CarRepository _carRepository;

  @override
  CarEntity? call(String params) {
    final car = _carRepository.getCarById(params);
    if (car == null) {
      _loggingService.error('Last seen car not found: $params');
    }

    return car;
  }
}
