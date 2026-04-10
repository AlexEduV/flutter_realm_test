import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/domain/data_sources/remote/auto_complete_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/car_auto_complete_entity.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/logger/base_logger.dart';
import '../../../domain/models/api_response.dart';

class MockAutoCompleteRemoteDataSource implements AutoCompleteRemoteDataSource {
  final BaseLogger _logger;

  MockAutoCompleteRemoteDataSource(this._logger);

  @override
  Future<List<CarAutoCompleteEntity>> getAutoCompleteModelListByType(CarType type) async {
    final resourceSrc = getResourceByType(type);

    final jsonString = await rootBundle.loadString('assets/mocks/$resourceSrc');

    final jsonDecoded = json.decode(jsonString);
    final response = ApiResponse.fromJson(
      jsonDecoded,
      (data) => (data as List)
          .map((item) => CarAutoCompleteEntity.fromJson(item as Map<String, dynamic>))
          .toList(),
    );

    if (response.status != ApiConstants.apiSuccessStatus) {
      _logger.e('Could not fetch autocomplete results: ${response.message}');
      return [];
    }

    final manufacturers = response.results ?? [];
    return manufacturers;
  }

  String getResourceByType(CarType type) {
    switch (type) {
      case CarType.car:
        return 'car_models_mock_response_data.json';
      case CarType.bike:
        return 'bike_models_mock_response_data.json';
      case CarType.truck:
        return 'truck_models_mock_response_data.json';
    }
  }
}
