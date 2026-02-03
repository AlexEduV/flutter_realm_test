import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class LocalisationUtil {
  //todo: use abstract local storage, so that the vendor might be changed easily

  Future<Map<String, dynamic>> loadLocalisations(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    return jsonMap;
  }

  Future<void> saveLocalisations(Map<String, dynamic> localisations) async {
    final prefs = await SharedPreferences.getInstance();
    localisations.forEach((key, value) async {
      await prefs.setString(key, value.toString());
    });
  }

  Future<String?> getLocalisation(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
