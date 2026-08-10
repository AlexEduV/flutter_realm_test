import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/country_picker_bottom_sheet.dart';

import '../../../common/fakes/image_fakes.dart';

void main() {
  testWidgets('CountryPickerBottomSheet renders items and handles selection', (
    WidgetTester tester,
  ) async {
    final items = [
      const RegionUiModel(code: 'us', countryName: 'countries.us'),
      const RegionUiModel(code: 'it', countryName: 'countries.it'),
      const RegionUiModel(code: 'fr', countryName: 'countries.fr'),
    ];

    final appLocalisationsCubit = AppLocalisationsCubit()
      ..load({
        'countries.us': 'United States',
        'countries.it': 'Italy',
        'countries.fr': 'France',
      });

    RegionUiModel? selected;
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: FakeAssetBundle(),
        child: BlocProvider<AppLocalisationsCubit>.value(
          value: appLocalisationsCubit,
          child: MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: ElevatedButton(
                  onPressed: () async {
                    selected = await showModalBottomSheet<RegionUiModel>(
                      context: context,
                      builder: (_) => BlocProvider<AppLocalisationsCubit>.value(
                        value: appLocalisationsCubit,
                        child: CountryPickerBottomSheet(items: items, currentSelectedIndex: 1),
                      ),
                    );
                  },
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(items.length));

    expect(find.text('United States'), findsOneWidget);
    expect(find.text('Italy'), findsOneWidget);
    expect(find.text('France'), findsOneWidget);

    final selectedTile = tester.widget<ListTile>(find.byType(ListTile).at(1));
    expect(selectedTile.selected, isTrue);

    await tester.tap(find.text('France'));
    await tester.pumpAndSettle();

    expect(selected, isNotNull);
    expect(selected!.code, 'fr');
    expect(selected!.countryName, 'countries.fr');
  });
}
