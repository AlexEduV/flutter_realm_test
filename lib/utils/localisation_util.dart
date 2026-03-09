import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/utils/json_util.dart';

import 'l10n.dart';

class LocalisationUtil {
  static Future<void> init(String locale) async {
    AppLocalisations.localisations = await LocalisationUtil.loadLocalisations(
      'assets/mocks/localisation_mock_response_data_$locale.json',
    );
    AppLocalisations.locale = locale;

    await initializeDateFormatting(AppLocalisations.locale, null);
    await LocalisationUtil.saveLocalisations(AppLocalisations.localisations);
  }

  //todo: use abstraction of shared preferences storage, so that the vendor might be changed easily

  static Future<Map<String, String>> loadLocalisations(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

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
