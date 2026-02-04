import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_futter_project/utils/localisation_util.dart';

@GenerateMocks([AssetBundle])
void main() {
  //late MockAssetBundle mockBundle;

  setUp(() {
    //mockBundle = MockAssetBundle();
    SharedPreferences.setMockInitialValues({});
  });

  group('LocalisationUtil', () {
    // test('loadLocalisations loads and flattens JSON', () async {
    //   // Arrange
    //   const jsonString = '''
    //   {
    //     "pages": {
    //       "home": {
    //         "title": "Home"
    //       }
    //     }
    //   }
    //   ''';
    //   final expectedFlat = {'pages.home.title': 'Home'};
    //
    //   // Mock rootBundle.loadString
    //   when(mockBundle.loadString('assets/localisations.json')).thenAnswer((_) async => jsonString);
    //
    //   // Patch rootBundle for this test
    //   final originalRootBundle = rootBundle;
    //   TestWidgetsFlutterBinding.ensureInitialized();
    //   ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler('flutter/assets', (
    //     message,
    //   ) async {
    //     return null;
    //   });
    //
    //   // Patch JsonUtil.flattenJson for this test
    //   JsonUtil.flattenJson = (Map<String, dynamic> json, [String prefix = '']) => expectedFlat;
    //
    //   // Act
    //   final result = await LocalisationUtil.loadLocalisations('assets/localisations.json');
    //
    //   // Assert
    //   expect(result, expectedFlat);
    //
    //   // Restore
    //   JsonUtil.flattenJson = JsonUtil.flattenJsonOriginal;
    // });

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
