import 'dart:ui';

import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetCarColorByNameUseCase extends UseCaseWithParams<String, Color?> {
  GetCarColorByNameUseCase(this._carColorRepository);

  final CarColorRepository _carColorRepository;

  @override
  Color? call(String colorName) {
    return _carColorRepository.getColorByName(colorName);
  }
}
