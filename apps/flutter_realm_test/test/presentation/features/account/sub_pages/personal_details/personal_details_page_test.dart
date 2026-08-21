import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';
import 'package:test_flutter_project/presentation/features/account/sub_pages/personal_details/personal_details_page.dart';
import 'package:test_flutter_project/presentation/features/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_state.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/features/user/user_data_state.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/edit_dialog_cubit.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/edit_password_dialog.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/edit_personal_info_dialog.dart';

import '../../../../../common/extensions/context_extension_test.mocks.dart';
import '../../../../../utils/app_router_test.mocks.dart';
import '../../../authentication/login_page_test.mocks.dart';

void main() {
  late MockUserDataCubit mockUserDataCubit;
  late MockAuthenticationCubit mockAuthCubit;
  late MockAppLocalisationsCubit mockAppLocalisationsCubit;

  final testUser = UserEntity.initial(
    userId: 'u1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    password: 'secret',
  );

  setUpAll(() {
    provideDummy(UserDataState(user: UserEntity.empty()));
  });

  setUp(() {
    mockUserDataCubit = MockUserDataCubit();
    mockAuthCubit = MockAuthenticationCubit();
    mockAppLocalisationsCubit = MockAppLocalisationsCubit();

    when(mockUserDataCubit.state).thenReturn(UserDataState(user: testUser));
    when(mockUserDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockAppLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockAppLocalisationsCubit.state).thenReturn(
      const AppLocalisationsState(localisations: {}),
    );

    when(mockAuthCubit.validateFullName(any, any)).thenReturn(true);
    when(mockAuthCubit.validateEmail(any, any)).thenReturn(true);
    when(mockAuthCubit.validatePassword(any, any)).thenReturn(true);
  });

  Widget buildWidget() {
    // All providers must be above MaterialApp so dialogs opened via showDialog
    // can also inherit them (dialog contexts sit on the Navigator overlay, not
    // inside the page's subtree).
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditDialogCubit>(create: (_) => EditDialogCubit()),
        BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
        BlocProvider<AppLocalisationsCubit>.value(value: mockAppLocalisationsCubit),
        BlocProvider<AuthenticationCubit>.value(value: mockAuthCubit),
      ],
      child: const MaterialApp(home: PersonalDetailsPage()),
    );
  }

  group('PersonalDetailsPage', () {
    testWidgets('renders AppBar and 4 PersonalDetailsListItems', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(PersonalDetailsListItem), findsNWidgets(4));
    });

    testWidgets('shows user data in list items', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
      expect(find.text('******'), findsOneWidget);
    });

    group('onTap — dialog opens', () {
      testWidgets('tapping First Name opens EditPersonalInfoDialog', (tester) async {
        await tester.pumpWidget(buildWidget());

        await tester.tap(find.byType(PersonalDetailsListItem).at(0));
        await tester.pumpAndSettle();

        expect(find.byType(EditPersonalInfoDialog), findsOneWidget);
      });

      testWidgets('tapping Last Name opens EditPersonalInfoDialog', (tester) async {
        await tester.pumpWidget(buildWidget());

        await tester.tap(find.byType(PersonalDetailsListItem).at(1));
        await tester.pumpAndSettle();

        expect(find.byType(EditPersonalInfoDialog), findsOneWidget);
      });

      testWidgets('tapping Email opens EditPersonalInfoDialog', (tester) async {
        await tester.pumpWidget(buildWidget());

        await tester.tap(find.byType(PersonalDetailsListItem).at(2));
        await tester.pumpAndSettle();

        expect(find.byType(EditPersonalInfoDialog), findsOneWidget);
      });

      testWidgets('tapping Password opens EditPasswordDialog', (tester) async {
        await tester.pumpWidget(buildWidget());

        await tester.tap(find.byType(PersonalDetailsListItem).at(3));
        await tester.pumpAndSettle();

        expect(find.byType(EditPasswordDialog), findsOneWidget);
      });
    });

    group('onTap — dialog pre-fills and confirms', () {
      testWidgets('First Name dialog is pre-filled and confirm calls setFirstName', (tester) async {
        await tester.pumpWidget(buildWidget());
        await tester.tap(find.byType(PersonalDetailsListItem).at(0));
        await tester.pumpAndSettle();

        // Verify the initial value is pre-filled
        final textField = find.byType(TextFormField).first;
        expect(tester.widget<TextFormField>(textField).controller?.text, 'John');

        // Tap the confirm button (enabled because validation returns true)
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        verify(mockUserDataCubit.setFirstName('John')).called(1);
        expect(find.byType(EditPersonalInfoDialog), findsNothing);
      });

      testWidgets('Last Name dialog is pre-filled and confirm calls setLastName', (tester) async {
        await tester.pumpWidget(buildWidget());
        await tester.tap(find.byType(PersonalDetailsListItem).at(1));
        await tester.pumpAndSettle();

        final textField = find.byType(TextFormField).first;
        expect(tester.widget<TextFormField>(textField).controller?.text, 'Doe');

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        verify(mockUserDataCubit.setLastName('Doe')).called(1);
        expect(find.byType(EditPersonalInfoDialog), findsNothing);
      });

      testWidgets('Email dialog is pre-filled and confirm calls setEmail', (tester) async {
        await tester.pumpWidget(buildWidget());
        await tester.tap(find.byType(PersonalDetailsListItem).at(2));
        await tester.pumpAndSettle();

        final textField = find.byType(TextFormField).first;
        expect(tester.widget<TextFormField>(textField).controller?.text, 'john.doe@example.com');

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        verify(mockUserDataCubit.setEmail('john.doe@example.com')).called(1);
        expect(find.byType(EditPersonalInfoDialog), findsNothing);
      });

      testWidgets('tapping cancel on First Name dialog does not call setFirstName', (tester) async {
        await tester.pumpWidget(buildWidget());
        await tester.tap(find.byType(PersonalDetailsListItem).at(0));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(TextButton));
        await tester.pumpAndSettle();

        verifyNever(mockUserDataCubit.setFirstName(any));
        expect(find.byType(EditPersonalInfoDialog), findsNothing);
      });

      testWidgets('editing first name field and confirming calls setFirstName with new value', (tester) async {
        await tester.pumpWidget(buildWidget());
        await tester.tap(find.byType(PersonalDetailsListItem).at(0));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).first, 'Jane');
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        verify(mockUserDataCubit.setFirstName('Jane')).called(1);
      });
    });

    group('validation', () {
      testWidgets('confirm button is disabled when validation returns false', (tester) async {
        when(mockAuthCubit.validateFullName(any, any)).thenReturn(false);

        await tester.pumpWidget(buildWidget());
        await tester.tap(find.byType(PersonalDetailsListItem).at(0));
        await tester.pumpAndSettle();

        final confirmButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(confirmButton.onPressed, isNull);
        verifyNever(mockUserDataCubit.setFirstName(any));
      });
    });
  });
}
