import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_flutter_project/domain/data_sources/remote/owners_remote_data_source.dart';
import 'package:test_flutter_project/domain/entities/owner_entity.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/constants/app_asset_routes.dart';
import '../../../domain/models/api_response.dart';

class SeedOwnersRemoteDataSourceImpl implements OwnersRemoteDataSource {
  SeedOwnersRemoteDataSourceImpl(this._logger);

  final LoggingService _logger;

  List<OwnerEntity> _owners = [];

  @override
  Future<List<OwnerEntity>> fetchOwners() async {
    final jsonString = await rootBundle.loadString(
      '${AppAssetRoutes.assetFolder}${AppAssetRoutes.mocksFolder}mock_owners.json',
    );
    final jsonDecoded = json.decode(jsonString);
    final response = ApiResponse.fromJson(
      jsonDecoded,
      (data) =>
          (data as List).map((item) => OwnerEntity.fromJson(item as Map<String, dynamic>)).toList(),
    );

    if (response.status != ApiConstants.apiSuccessStatus) {
      _logger.error('Could not fetch owners: ${response.message}');
      return [];
    }

    _owners = response.results ?? [];
    return _owners;
  }

  @override
  OwnerEntity getOwnerById(String id) {
    final owner = _owners.where((element) => element.id == id).firstOrNull;
    if (owner == null) {
      return OwnerEntity.empty();
    }

    return owner;
  }
}
