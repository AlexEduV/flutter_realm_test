import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/mocks/mock_users.dart';

import '../../../common/app_constants.dart';
import '../../../domain/models/api_response.dart';

class MockOwnersRemoteDataSource implements OwnersRemoteDataSource {
  List<OwnerEntity> _owners = [];

  @override
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

    for (final owner in _owners) {
      final newUser = UserEntity.fromOwner(owner);
      final exists = MockUsers.initialUsers.any((u) => u.userId == newUser.userId);
      if (!exists) {
        MockUsers.initialUsers.add(newUser);
      }
    }
    await MockUsers.saveMockUsers(MockUsers.initialUsers);

    return _owners;
  }

  @override
  OwnerEntity getOwnerById(String id) {
    final owner = _owners.where((element) => element.id == id).firstOrNull;
    return owner ?? OwnerEntity.empty();
  }
}
