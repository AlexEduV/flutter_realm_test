import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:test_flutter_project/domain/data_sources/remote/app_remote_storage.dart';
import 'package:test_flutter_project/domain/models/api_response.dart';
import 'package:test_flutter_project/utils/json_util.dart';

import '../common/constants/api_constants.dart';

class LocalisationUtil {
  LocalisationUtil(this._remoteStorage);
  final AppRemoteStorage _remoteStorage;

  Future<Map<String, dynamic>> loadRawJson(String path) async {
    final jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  Map<String, String>? extractLocalisations(Map<String, dynamic> rawJson) {
    final response = ApiResponse.fromJson(rawJson, (json) => json as List);

    if (response.status != ApiConstants.apiSuccessStatus || response.results == null) {
      return null;
    }

    final Map<String, dynamic>? jsonMap = response.results?.firstOrNull;
    if (jsonMap == null) return null;

    return JsonUtil.flattenJson(jsonMap);
  }

  Future<void> saveLocalisations(Map<String, dynamic> localisations) async {
    await Future.wait(
      localisations.entries.map((e) => _remoteStorage.setString(e.key, e.value.toString())),
    );
  }

  Future<String> getLocalisation(String key) async {
    return _remoteStorage.getString(key) ?? '';
  }
}
