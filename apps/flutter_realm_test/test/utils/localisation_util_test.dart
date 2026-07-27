import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/utils/localisation_util.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('LocalisationUtil.extractLocalisations', () {
    test('returns flattened map on success', () {
      final rawJson = {
        'status': 'success',
        'message': '',
        'results': [
          {
            'app': {'locale': 'en'},
            'greeting': 'Hello',
          },
        ],
      };

      final result = LocalisationUtil.extractLocalisations(rawJson);

      expect(result, {'app.locale': 'en', 'greeting': 'Hello'});
    });

    test('returns null when status is not success', () {
      final rawJson = {
        'status': 'error',
        'message': '',
        'results': [
          {'greeting': 'Hello'},
        ],
      };

      expect(LocalisationUtil.extractLocalisations(rawJson), isNull);
    });

    test('returns null when results is null', () {
      final rawJson = {'status': 'success', 'message': '', 'results': null};

      expect(LocalisationUtil.extractLocalisations(rawJson), isNull);
    });

    test('returns null when results list is empty', () {
      final rawJson = {'status': 'success', 'message': '', 'results': []};

      expect(LocalisationUtil.extractLocalisations(rawJson), isNull);
    });
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
