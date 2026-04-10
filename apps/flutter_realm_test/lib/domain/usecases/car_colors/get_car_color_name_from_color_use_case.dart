import 'dart:ui';

import 'package:test_futter_project/domain/repositories/car_color_repository.dart';
import 'package:test_futter_project/domain/usecases/usecase.dart';

class GetCarColorNameFromColorUseCase extends UseCaseWithParams<Color?, String> {
  final CarColorRepository _carColorRepository;

  GetCarColorNameFromColorUseCase(this._carColorRepository);

  @override
  String call(Color? color) {
    return _carColorRepository.getColorNameFromColor(color);
  }
}
