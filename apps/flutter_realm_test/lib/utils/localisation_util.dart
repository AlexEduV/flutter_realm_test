import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/domain/models/api_response.dart';
import 'package:test_flutter_project/utils/json_util.dart';

import '../common/constants/api_constants.dart';

class LocalisationUtil {
  //todo: use abstraction of shared preferences storage, so that the vendor might be changed easily

  static Future<Map<String, dynamic>> loadRawJson(String path) async {
    final jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  static Map<String, String>? extractLocalisations(Map<String, dynamic> rawJson) {
    final response = ApiResponse.fromJson(rawJson, (json) => json as List);

    if (response.status != ApiConstants.apiSuccessStatus || response.results == null) {
      return null;
    }

    final Map<String, dynamic>? jsonMap = response.results?.firstOrNull;
    if (jsonMap == null) return null;

    return JsonUtil.flattenJson(jsonMap);
  }

  static Future<void> saveLocalisations(Map<String, dynamic> localisations) async {
    final prefs = await SharedPreferences.getInstance();

    await Future.wait(
      localisations.entries.map((e) => prefs.setString(e.key, e.value.toString())),
    );
  }

  static Future<String> getLocalisation(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }
}
