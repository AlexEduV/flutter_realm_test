import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';

import '../../../common/app_constants.dart';
import '../../../domain/models/api_response.dart';

class MockOwnersRemoteDataSource {
  List<OwnerEntity> _owners = [];

  Future<List<OwnerEntity>> fetchOwners() async {
    final jsonString = await rootBundle.loadString('assets/mocks/mock_owners.json');
    final jsonDecoded = json.decode(jsonString);
    final response = ApiResponse.fromJson(
      jsonDecoded,
      (data) =>
          (data as List).map((item) => OwnerEntity.fromJson(item as Map<String, dynamic>)).toList(),
    );

    if (response.status != AppConstants.apiSuccessStatus) {
      //todo: add logs;
      return [];
    }

    _owners = response.results ?? [];

    return _owners;
  }

  Future<OwnerEntity?> getOwnerById(String id) async {
    return _owners.where((element) => element.id == id).firstOrNull;
  }
}
