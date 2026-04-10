import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:test_futter_project/domain/data_sources/local/car_colors_local_data_source.dart';

import '../../common/extensions/string_extension.dart';
import '../../domain/repositories/car_color_repository.dart';

class CarColorRepositoryImpl implements CarColorRepository {
  final CarColorLocalDataSource _carColorLocalDataSource;

  const CarColorRepositoryImpl(this._carColorLocalDataSource);

  @override
  Map<String, Color> getColors() {
    return _carColorLocalDataSource.getColors();
  }

  @override
  Color? getColorByName(String colorName) {
    final colors = getColors();

    Color? color = colors.entries
        .firstWhereOrNull((element) => element.key == colorName.toLowerCase())
        ?.value;

    return color ??= colors.values.firstOrNull;
  }

  @override
  String getColorNameFromColor(Color? color) {
    final colors = getColors();

    String? result = colors.entries
        .firstWhereOrNull((element) => element.value == color)
        ?.key
        .camelCaseToTitle();

    return result ??= '';
  }
}
