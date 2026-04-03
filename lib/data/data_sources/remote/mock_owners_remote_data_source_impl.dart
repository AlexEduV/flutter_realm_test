import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_futter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_futter_project/domain/entities/owner_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/domain/usecases/users/save_users_use_case.dart';

import '../../../common/constants/api_constants.dart';
import '../../../core/di/injection_container.dart';
import '../../../domain/data_sources/remote/users_remote_data_source.dart';
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

    if (response.status != ApiConstants.apiSuccessStatus) {
      //todo: add logs;
      return [];
    }

    _owners = response.results ?? [];

    for (final owner in _owners) {
      final newUser = UserEntity.fromOwner(owner);
      final exists = serviceLocator<UsersRemoteDataSource>().users.any(
        (u) => u.userId == newUser.userId,
      );
      if (!exists) {
        serviceLocator<UsersRemoteDataSource>().users.add(newUser);
      }
    }
    await serviceLocator<SaveUsersUseCase>().call(serviceLocator<UsersRemoteDataSource>().users);

    return _owners;
  }

  @override
  OwnerEntity getOwnerById(String id) {
    final owner = _owners.where((element) => element.id == id).firstOrNull;
    return owner ?? OwnerEntity.empty();
  }
}
