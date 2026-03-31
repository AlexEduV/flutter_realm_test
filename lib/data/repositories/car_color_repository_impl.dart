import 'dart:ui';

import 'package:test_futter_project/domain/data_sources/local/car_colors_local_data_source.dart';

import '../../domain/repositories/car_color_repository.dart';

class CarColorRepositoryImpl implements CarColorRepository {
  final CarColorLocalDataSource _carColorLocalDataSource;

  const CarColorRepositoryImpl(this._carColorLocalDataSource);

  @override
  Map<String, Color> getColors() {
    return _carColorLocalDataSource.getColors();
  }
}
