import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/domain/models/api_response.dart';
import 'package:test_futter_project/utils/json_util.dart';

class LocalisationUtil {
  //todo: use abstraction of shared preferences storage, so that the vendor might be changed easily

  static Future<Map<String, String>> loadLocalisations(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonDecoded = json.decode(jsonString);

    final response = ApiResponse.fromJson(jsonDecoded, (json) => json as List);

    if (response.status != 'success' || response.results == null) {
      return {};
    }

    final Map<String, dynamic> jsonMap = response.results?.firstOrNull ?? {};
    final flatMap = JsonUtil.flattenJson(jsonMap);

    return flatMap;
  }

  static Future<void> saveLocalisations(Map<String, dynamic> localisations) async {
    final prefs = await SharedPreferences.getInstance();
    localisations.forEach((key, value) async {
      await prefs.setString(key, value.toString());
    });
  }

  static Future<String> getLocalisation(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }
}
