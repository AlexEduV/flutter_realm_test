import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/repositories/car_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class DeleteCarByIdUseCase implements UseCaseWithParams<void, ObjectId> {
  DeleteCarByIdUseCase(this._carRepository);

  final CarRepository _carRepository;

  @override
  Future<void> call(ObjectId params) async {
    return _carRepository.deleteCarById(params);
  }
}
