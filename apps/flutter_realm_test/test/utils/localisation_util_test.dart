import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/data/data_sources/remote/shared_preferences_storage.dart';
import 'package:test_flutter_project/utils/localisation_util.dart';

void main() {
  late LocalisationUtil localisationUtil;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    localisationUtil = LocalisationUtil(SharedPreferencesStorage(prefs));
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

      expect(localisationUtil.extractLocalisations(rawJson), {'app.locale': 'en', 'greeting': 'Hello'});
    });

    test('returns null when status is not success', () {
      final rawJson = {
        'status': 'error',
        'message': '',
        'results': [
          {'greeting': 'Hello'},
        ],
      };

      expect(localisationUtil.extractLocalisations(rawJson), isNull);
    });

    test('returns null when results is null', () {
      final rawJson = {'status': 'success', 'message': '', 'results': null};

      expect(localisationUtil.extractLocalisations(rawJson), isNull);
    });

    test('returns null when results list is empty', () {
      final rawJson = {'status': 'success', 'message': '', 'results': []};

      expect(localisationUtil.extractLocalisations(rawJson), isNull);
    });
  });

  group('LocalisationUtil', () {
    test('saveLocalisations saves all key-value pairs to SharedPreferences', () async {
      await localisationUtil.saveLocalisations({'key1': 'value1', 'key2': 'value2'});

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('key1'), 'value1');
      expect(prefs.getString('key2'), 'value2');
    });

    test('getLocalisation returns value from SharedPreferences', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('test.key', 'Test Value');

      expect(await localisationUtil.getLocalisation('test.key'), 'Test Value');
    });

    test('getLocalisation returns empty string if key is missing', () async {
      expect(await localisationUtil.getLocalisation('missing.key'), '');
    });
  });
}
