import 'dart:ui';

import 'package:test_flutter_project/domain/repositories/car_color_repository.dart';
import 'package:test_flutter_project/domain/usecases/usecase.dart';

class GetCarColorNameFromColorUseCase
    extends UseCaseWithParams<Color?, String> {
  GetCarColorNameFromColorUseCase(this._carColorRepository);

  final CarColorRepository _carColorRepository;

  @override
  String call(Color? color) {
    return _carColorRepository.getColorNameFromColor(color);
  }
}
