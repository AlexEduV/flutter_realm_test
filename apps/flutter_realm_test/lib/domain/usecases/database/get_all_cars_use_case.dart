import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/repositories/car_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetAllCarsUseCase implements UseCaseNoParams<List<CarEntity>> {
  GetAllCarsUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  List<CarEntity> call() {
    return _carRepository.getAllCars();
  }
}
