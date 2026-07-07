import 'dart:ui' show Color;

import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetCarColorsUseCase extends UseCaseNoParams<Map<String, Color>> {
  GetCarColorsUseCase(this._carColorRepository);

  final CarColorRepository _carColorRepository;

  @override
  Map<String, Color> call() {
    return _carColorRepository.getColors();
  }
}
