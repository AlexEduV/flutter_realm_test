import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/domain/data_sources/remote/auto_complete_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/car_auto_complete_entity.dart';

import '../../../common/api_constants.dart';
import '../../../domain/models/api_response.dart';

class MockAutoCompleteRemoteDataSource implements AutoCompleteRemoteDataSource {
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
      //todo: add logs;
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
