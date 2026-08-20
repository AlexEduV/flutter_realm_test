import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:test_flutter_project/data/data_sources/remote/shared_preferences_storage.dart';
import 'package:test_flutter_project/utils/localisation_util.dart';

void main() {
  late LocalisationUtil localisationUtil;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
    final prefs = SharedPreferencesAsync();
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

      expect(localisationUtil.extractLocalisations(rawJson), {
        'app.locale': 'en',
        'greeting': 'Hello',
      });
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

      expect(await localisationUtil.getLocalisation('key1'), 'value1');
      expect(await localisationUtil.getLocalisation('key2'), 'value2');
    });

    test('getLocalisation returns value from SharedPreferences', () async {
      final prefs = SharedPreferencesAsync();
      await prefs.setString('test.key', 'Test Value');

      expect(await localisationUtil.getLocalisation('test.key'), 'Test Value');
    });

    test('getLocalisation returns empty string if key is missing', () async {
      expect(await localisationUtil.getLocalisation('missing.key'), '');
    });
  });
}
