import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/data/data_sources/remote/mock_users_remote_data_source_impl.dart';
import 'package:test_futter_project/di/injection_container.dart';
import 'package:test_futter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/users/save_users_use_case.dart';

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
      final exists = serviceLocator<MockUsersRemoteDataSourceImpl>().initialUsers.any(
        (u) => u.userId == newUser.userId,
      );
      if (!exists) {
        serviceLocator<MockUsersRemoteDataSourceImpl>().initialUsers.add(newUser);
      }
    }
    await serviceLocator<SaveUsersUseCase>().call(
      serviceLocator<MockUsersRemoteDataSourceImpl>().initialUsers,
    );

    return _owners;
  }

  @override
  OwnerEntity getOwnerById(String id) {
    final owner = _owners.where((element) => element.id == id).firstOrNull;
    return owner ?? OwnerEntity.empty();
  }
}
