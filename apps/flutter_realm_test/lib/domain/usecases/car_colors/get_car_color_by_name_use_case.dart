import 'dart:ui';

import 'package:test_futter_project/domain/repositories/car_color_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetCarColorByNameUseCase extends UseCaseWithParams<String, Color?> {
  final CarColorRepository _carColorRepository;

  GetCarColorByNameUseCase(this._carColorRepository);

  @override
  Color? call(String colorName) {
    return _carColorRepository.getColorByName(colorName);
  }
}
