import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class DeleteCarByIdUseCase implements UseCaseWithParams<ObjectId, void> {
  DeleteCarByIdUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  void call(ObjectId params) {
    return _carRepository.deleteCarById(params);
  }
}
