import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/utils/localisation_util.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('LocalisationUtil', () {
    test('saveLocalisations saves all key-value pairs to SharedPreferences', () async {
      final localisations = {'key1': 'value1', 'key2': 'value2'};

      await LocalisationUtil.saveLocalisations(localisations);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('key1'), 'value1');
      expect(prefs.getString('key2'), 'value2');
    });

    test('getLocalisation returns value from SharedPreferences', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('test.key', 'Test Value');

      final value = await LocalisationUtil.getLocalisation('test.key');
      expect(value, 'Test Value');
    });

    test('getLocalisation returns empty string if key is missing', () async {
      final value = await LocalisationUtil.getLocalisation('missing.key');
      expect(value, '');
    });
  });
}
