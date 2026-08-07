import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/domain/models/region_ui_model.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_color_by_name_use_case.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_color_name_from_color_use_case.dart';
import 'package:test_flutter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/messages/messages_page_state.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/confirmation_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/country_picker_bottom_sheet.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/edit_password_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/edit_personal_info_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/gifs_picker_bottom_sheet.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/inbox_item_menu_bottom_sheet.dart';
import 'package:test_flutter_project/utils/dialog_helper.dart';

import '../common/fakes/image_fakes.dart';
import '../presentation/pages/details/widgets/vehicle_specs_widget_test.mocks.dart';
import '../presentation/pages/messages/messages_page_test.mocks.dart';
import '../presentation/widgets/dialogs/color_picker_dialog/color_picker_dialog_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final appLocalisationsCubit = AppLocalisationsCubit();

  setUpAll(() {
    appLocalisationsCubit.load({
      L10nKeys.personalDetailsItemPasswordDialogLabel: 'New Password',
      L10nKeys.personalDetailsItemPasswordDialogSecondLabel: 'Confirm Password',
      L10nKeys.conversationDialogDeleteItemTitle: 'Delete conversation',
      L10nKeys.gifsTextFieldHint: 'Search GIFs',
      L10nKeys.gifsResultsTrendingLabel: 'Trending',
      L10nKeys.pickColorDialogTitle: 'Pick a color',
      L10nKeys.cancelLabel: 'Cancel',
      L10nKeys.confirmLabel: 'Confirm',
    });
  });

  testWidgets('showConfirmationDialog shows ConfirmationDialog', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                DialogHelper.showConfirmationDialog(
                  context,
                  title: 'Title',
                  description: 'Desc',
                  onConfirm: () {},
                  confirmButtonTitle: 'OK',
                  cancelButtonTitle: 'Cancel',
                );
              },
              child: const Text('Open'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(ConfirmationDialog), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Desc'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('showEditDialog shows EditPersonalInfoDialog', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [BlocProvider<EditDialogCubit>(create: (_) => EditDialogCubit())],
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  DialogHelper.showEditDialog(
                    context,
                    title: 'Edit',
                    initialValue: 'init',
                    confirmButtonTitle: 'Save',
                    cancelButtonTitle: 'Cancel',
                    onConfirm: (_) {},
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(EditPersonalInfoDialog), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('showEditPasswordDialog shows EditPasswordDialog', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          BlocProvider<EditDialogCubit>(create: (_) => EditDialogCubit()),
        ],
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  DialogHelper.showEditPasswordDialog(
                    context,
                    title: 'Password',
                    confirmButtonTitle: 'OK',
                    cancelButtonTitle: 'Cancel',
                    onConfirm: (_) {},
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(EditPasswordDialog), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('showCountryPicker shows CountryPickerBottomSheet and items', (tester) async {
    final items = [
      const RegionUiModel(code: 'US', countryName: 'United States'),
      const RegionUiModel(code: 'IT', countryName: 'Italy'),
    ];

    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: FakeAssetBundle(),
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => DialogHelper.showCountryPicker(context, items, 0),
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(CountryPickerBottomSheet), findsOneWidget);
    expect(find.text('United States'), findsOneWidget);
    expect(find.text('Italy'), findsOneWidget);
  });

  testWidgets('showInboxItemModalBottomSheet shows InboxItemMenuBottomSheet', (tester) async {
    final mockInboxCubit = MockInboxPageCubit();
    when(mockInboxCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockInboxCubit.state).thenReturn(const InboxPageState());

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          BlocProvider<InboxPageCubit>.value(value: mockInboxCubit),
        ],
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => DialogHelper.showInboxItemModalBottomSheet(context, 'conv1'),
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(InboxItemMenuBottomSheet), findsOneWidget);
  });

  testWidgets('showGifsPickerModalBottomSheet shows GifsPickerBottomSheet', (tester) async {
    final listKey = GlobalKey<AnimatedListState>();
    final mockMessagesPageCubit = MockMessagesPageCubit();
    when(mockMessagesPageCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockMessagesPageCubit.state).thenReturn(const MessagesPageState());

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          BlocProvider<MessagesPageCubit>.value(value: mockMessagesPageCubit),
        ],
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => DialogHelper.showGifsPickerModalBottomSheet(context, listKey),
                child: const Text('Open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(GifsPickerBottomSheet), findsOneWidget);
  });

  group('showColorsPickerDialog', () {
    setUp(() {
      final mockGetCarColorsUseCase = MockGetCarColorsUseCase();
      final mockGetCarColorByNameUseCase = MockGetCarColorByNameUseCase();
      final mockGetCarColorNameFromColorUseCase = MockGetCarColorNameFromColorUseCase();

      when(mockGetCarColorsUseCase.call()).thenReturn({'red': Colors.red, 'blue': Colors.blue});
      when(mockGetCarColorByNameUseCase.call(any)).thenReturn(Colors.red);
      when(mockGetCarColorNameFromColorUseCase.call(any)).thenReturn('red');

      serviceLocator.registerSingleton<GetCarColorsUseCase>(mockGetCarColorsUseCase);
      serviceLocator.registerSingleton<GetCarColorByNameUseCase>(mockGetCarColorByNameUseCase);
      serviceLocator.registerSingleton<GetCarColorNameFromColorUseCase>(
        mockGetCarColorNameFromColorUseCase,
      );
    });

    tearDown(() {
      serviceLocator.unregister<GetCarColorsUseCase>();
      serviceLocator.unregister<GetCarColorByNameUseCase>();
      serviceLocator.unregister<GetCarColorNameFromColorUseCase>();
    });

    testWidgets('shows ColorPickerDialog', (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit)],
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => DialogHelper.showColorsPickerDialog(context, 'red'),
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(ColorPickerDialog), findsOneWidget);
    });
  });
}
